import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_deer_djzhang/res/constant.dart';
import 'package:flutter_deer_djzhang/demo/demo_page.dart';
import 'package:flutter_deer_djzhang/login/login_router.dart';
import 'package:flutter_deer_djzhang/routers/routers.dart';
import 'package:flutter_deer_djzhang/routers/fluro_navigator.dart';
import 'package:flutter_deer_djzhang/util/app_navigator.dart';
import 'package:flutter_deer_djzhang/util/device_utils.dart';
import 'package:flutter_deer_djzhang/util/image_utils.dart';
import 'package:flutter_deer_djzhang/util/theme_utils.dart';
import 'package:flutter_deer_djzhang/widgets/load_image.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:sp_util/sp_util.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  final List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      /// 两种初始化方案，另一种见 main.dart
      /// 两种方法各有优劣
      await SpUtil.getInstance();
      await Device.initDeviceInfo();
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)!) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        void _precacheImage(String image) {
          precacheImage(
              ImageUtils.getAssetImage(image, format: ImageFormat.webp),
              context);
        }

        _guideList.forEach(_precacheImage);
      }
      _initSplash();
    });

    /// 设置桌面端窗口大小
    if (Device.isDesktop) {
      DesktopWindow.setWindowSize(const Size(400, 800));
    }
    if (Device.isAndroid) {
      const QuickActions quickActions = QuickActions();
      quickActions.initialize((String shortcutType) async {
        if (shortcutType == 'demo') {
          AppNavigator.pushReplacement(context, const DemoPage());
          _subscription?.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
    _subscription =
        Stream.value(1).delay(const Duration(milliseconds: 1500)).listen((_) {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)! ||
          Constant.isDriverTest) {
        SpUtil.putBool(Constant.keyGuide, false);
        _initGuide();
      } else {
        // _initGuide();
        _goLogin();
      }
    });
  }

  void _goLogin() {
    // NavigatorUtils.push(context, LoginRouter.loginPage, replace: true);
    // TODO: DJZHANG
    NavigatorUtils.push(context, Routes.home, clearStack: true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: context.backgroundColor,
        child: _status == 0
            ? const FractionallyAlignedSizedBox(
                heightFactor: 0.3,
                widthFactor: 0.33,
                leftFactor: 0.33,
                bottomFactor: 0,
                child: LoadAssetImage('logo'))
            : Swiper(
                key: const Key('swiper'),
                itemCount: _guideList.length,
                loop: false,
                itemBuilder: (_, index) {
                  return LoadAssetImage(
                    _guideList[index],
                    key: Key(_guideList[index]),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    format: ImageFormat.webp,
                  );
                },
                onTap: (index) {
                  if (index == _guideList.length - 1) {
                    _goLogin();
                  }
                },
              ));
  }
}
