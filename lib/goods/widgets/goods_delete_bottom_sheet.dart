import 'package:flutter/material.dart';
import 'package:flutter_deer_djzhang/res/resources.dart';
import 'package:flutter_deer_djzhang/routers/fluro_navigator.dart';
import 'package:flutter_deer_djzhang/widgets/my_button.dart';

/// design/4商品/index.html#artboard2
class GoodsDeleteBottomSheet extends StatelessWidget {
  const GoodsDeleteBottomSheet({
    Key? key,
    required this.onTapDelete,
  }) : super(key: key);

  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 52.0,
              child: Center(
                child: Text(
                  '是否确认删除，防止错误操作',
                  style: AppTextStyles.textSize16,
                ),
              ),
            ),
            Gaps.line,
            MyButton(
              minHeight: 54.0,
              textColor: Theme.of(context).errorColor,
              text: '确认删除',
              backgroundColor: Colors.transparent,
              onPressed: () {
                NavigatorUtils.goBack(context);
                onTapDelete();
              },
            ),
            Gaps.line,
            MyButton(
              minHeight: 54.0,
              textColor: AppColors.text_gray,
              text: '取消',
              backgroundColor: Colors.transparent,
              onPressed: () {
                NavigatorUtils.goBack(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
