import 'package:flutter/material.dart';
import 'package:flutter_deer_djzhang/widgets/load_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../res/dimens.dart';
import '../../../res/gaps.dart';
import '../../../res/styles.dart';
import '../../../util/device_utils.dart';
import '../../../util/other_utils.dart';
import '../../models/goods_size_model.dart';

class GoodsSizeItem extends StatelessWidget {
  const GoodsSizeItem(
    this.index, {
    Key? key,
    required this.item,
    required this.slidableController,
  }) : super(key: key);

  // 保留一个Slidable打开
  final SlidableController slidableController;

  final GoodsSizeModel item;
  final int index;

  @override
  Widget build(BuildContext context) {
    // item
    Widget widget = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LoadAssetImage(item.icon, width: 72.0, height: 72.0),
        Gaps.hGap8,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item.sizeName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '库存${item.stock}',
                    style: AppTextStyles.textSize12,
                  ),
                ],
              ),
              Gaps.vGap4,
              Row(
                children: <Widget>[
                  Offstage(
                    offstage: item.reducePrice.isEmpty,
                    child: _buildGoodsTag(
                        Theme.of(context).errorColor, '立减${item.reducePrice}元'),
                  ),
                  Opacity(
                    opacity: item.currencyPrice.isEmpty ? 0.0 : 1.0,
                    child: _buildGoodsTag(Theme.of(context).primaryColor,
                        '金币抵扣${item.currencyPrice}元'),
                  )
                ],
              ),
              Gaps.vGap16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(Utils.formatPrice(item.price)),
                  const SizedBox(
                    width: 50.0,
                  ),
                  Text(
                    '佣金${item.charges}元',
                    style: AppTextStyles.textSize12,
                  ),
                  Text(
                    '起购${item.minSaleNum}件',
                    style: AppTextStyles.textSize12,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );

    // item装饰
    widget = InkWell(
      onTap: () {
        /// 如果侧滑菜单打开，关闭侧滑菜单。否则跳转
        if (slidableController.activeState != null) {
          slidableController.activeState!.close();
        } else {
          // NavigatorUtils.push(context, GoodsRouter.goodsSizeEditPage);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: Divider.createBorderSide(context, width: 0.8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
            child: widget,
          ),
        ),
      ),
    );

    // 侧滑删除
    return Slidable(
      key: Key(index.toString()),
      controller: slidableController,
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,

      ///右侧的action
      secondaryActions: <Widget>[
        SlideAction(
          child: Semantics(
            label: '删除',
            child: Container(
              width: 72.0,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: LoadAssetImage(
                'goods/goods_delete',
                key: Key('delete_$index'),
              ),
            ),
          ),
          color: Theme.of(context).errorColor,
          onTap: () {
            // setState(() {
            // _goodsSizeList.removeAt(index);
            // });
          },
        ),
      ],
      child: widget,
    );
  }

  Widget _buildGoodsTag(Color color, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.0),
      ),
      height: 16.0,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: AppDimens.font_sp10,
          height: Device.isAndroid ? 1.1 : null,
        ),
      ),
    );
  }
}
