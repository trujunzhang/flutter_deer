import 'package:flutter/material.dart';

import '../../../res/dimens.dart';

class GoodsTabView extends StatelessWidget {
  const GoodsTabView(this.tabName, this.index);

  final String tabName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox(
        width: 98.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(tabName),
            Visibility(
              // visible: !(provider.goodsCountList[index] == 0 ||
              // provider.index != index),
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: Text(
                  // ' (${provider.goodsCountList[index]}件)',
                  '',
                  style: const TextStyle(fontSize: AppDimens.font_sp12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
