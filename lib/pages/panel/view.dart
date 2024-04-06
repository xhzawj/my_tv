import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:my_tv/common/index.dart';
import 'package:my_tv/pages/panel/widgets/iptv_ch.dart';
import 'package:my_tv/pages/panel/widgets/iptv_info.dart';
import 'package:my_tv/pages/panel/widgets/iptv_list.dart';
import 'package:my_tv/pages/panel/widgets/player_info.dart';
import 'package:my_tv/pages/panel/widgets/time.dart';

class PanelPage extends StatefulWidget {
  const PanelPage({super.key});

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {
  final playerStore = GetIt.I<PlayerStore>();
  final iptvStore = GetIt.I<IptvStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.5),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                _buildTopRight(context),
                _buildBottom(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 右上角
  Widget _buildTopRight(BuildContext context) {
    return Positioned(
      top: 20.h,
      right: 20.w,
      child: Row(
        children: [
          Observer(
            builder: (_) => PanelIptvChannel(iptvStore.currentIptv.channel.toString().padLeft(2, '0')),
          ),
          // 分隔符
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 12, 0).r,
            child: SizedBox(
              height: 50.w,
              child: VerticalDivider(
                thickness: 2.w,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          const PanelTime(),
        ],
      ),
    );
  }

  // 底部
  Positioned _buildBottom() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 40).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PanelIptvInfo(),
            SizedBox(height: 30.h),
            PanelPlayerInfo(),
            SizedBox(height: 30.h),
            const PanelIptvList(),
          ],
        ),
      ),
    );
  }
}
