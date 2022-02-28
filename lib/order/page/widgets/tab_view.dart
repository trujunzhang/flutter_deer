import 'package:flutter/material.dart';
import 'package:flutter_deer/res/Dimens.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';

List<List<String>> img = [
  ['order/xdd_s', 'order/xdd_n'],
  ['order/dps_s', 'order/dps_n'],
  ['order/dwc_s', 'order/dwc_n'],
  ['order/ywc_s', 'order/ywc_n'],
  ['order/yqx_s', 'order/yqx_n']
];

List<List<String>> darkImg = [
  ['order/dark/icon_xdd_s', 'order/dark/icon_xdd_n'],
  ['order/dark/icon_dps_s', 'order/dark/icon_dps_n'],
  ['order/dark/icon_dwc_s', 'order/dark/icon_dwc_n'],
  ['order/dark/icon_ywc_s', 'order/dark/icon_ywc_n'],
  ['order/dark/icon_yqx_s', 'order/dark/icon_yqx_n']
];

class TabView extends StatelessWidget {
  const TabView(this.index, this.text);

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    final List<List<String>> imgList = context.isDark ? darkImg : img;
    return Stack(
      children: <Widget>[
        Container(
          width: 46.0,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /// 使用context.select替代Consumer
              LoadAssetImage(
                // context.select<OrderPageProvider, int>(
                //             (value) => value.index) ==
                //         index
                //     ? imgList[index][0]
                //     :
                imgList[index][1],
                width: 24.0,
                height: 24.0,
              ),
              Gaps.vGap4,
              Text(text),
            ],
          ),
        ),
        Positioned(
          right: 0.0,
          child: index < 3
              ? DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).errorColor,
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.5, vertical: 2.0),
                    child: Text(
                      '10',
                      style: TextStyle(
                          color: Colors.white, fontSize: AppDimens.font_sp12),
                    ),
                  ),
                )
              : Gaps.empty,
        )
      ],
    );
  }
}
