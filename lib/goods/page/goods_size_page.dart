import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer_djzhang/goods/models/goods_size_model.dart';
import 'package:flutter_deer_djzhang/goods/widgets/goods_size_dialog.dart';
import 'package:flutter_deer_djzhang/res/resources.dart';
import 'package:flutter_deer_djzhang/routers/fluro_navigator.dart';
import 'package:flutter_deer_djzhang/util/device_utils.dart';
import 'package:flutter_deer_djzhang/util/image_utils.dart';
import 'package:flutter_deer_djzhang/util/toast_utils.dart';
import 'package:flutter_deer_djzhang/util/other_utils.dart';
import 'package:flutter_deer_djzhang/widgets/my_app_bar.dart';
import 'package:flutter_deer_djzhang/widgets/load_image.dart';
import 'package:flutter_deer_djzhang/widgets/my_button.dart';
import 'package:flutter_deer_djzhang/widgets/popup_window.dart';
import 'package:flutter_deer_djzhang/widgets/state_layout.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../goods_router.dart';
import 'widgets/goods_size_item.dart';

/// design/4商品/index.html#artboard9
class GoodsSizePage extends StatefulWidget {
  const GoodsSizePage({Key? key}) : super(key: key);

  @override
  _GoodsSizePageState createState() => _GoodsSizePageState();
}

class _GoodsSizePageState extends State<GoodsSizePage> {
  bool _isEdit = false;
  String _sizeName = '商品规格名称';
  final GlobalKey _hintKey = GlobalKey();

  final List<GoodsSizeModel> _goodsSizeList = [];

  // 保留一个Slidable打开
  final SlidableController _slidableController = SlidableController();

  @override
  void initState() {
    super.initState();
    _goodsSizeList.clear();
    _goodsSizeList.add(GoodsSizeModel(
        'goods/goods_size_1', '黑色', 1000, '50.0', 2, '2', '2', '2'));
    _goodsSizeList.add(GoodsSizeModel(
        'goods/goods_size_2', '银色', 100, '51.0', 1, '', '2', '1'));
    _goodsSizeList.add(GoodsSizeModel(
        'goods/goods_size_1', '黑色1', 1050, '50.0', 2, '20', '2', ''));
    _goodsSizeList.add(GoodsSizeModel(
        'goods/goods_size_2', '银色1', 1000, '55.0', 2, '', '10', '2'));
    _goodsSizeList.add(GoodsSizeModel(
        'goods/goods_size_1', '黑色2', 500, '56', 2, '2', '2', '2'));
    _goodsSizeList.add(GoodsSizeModel(
        'goods/goods_size_2', '银色2', 110, '51.0', 2, '2', '1', ''));
    _goodsSizeList.add(GoodsSizeModel(
        'goods/goods_size_1', '黑色3', 10, '50.0', 2, '2', '2.5', ''));

    // 获取Build完成状态监听
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _showHint();
    });
  }

  /// design/4商品/index.html#artboard18
  void _showHint() {
    final RenderBox hint =
        _hintKey.currentContext!.findRenderObject()! as RenderBox;
    showPopupWindow<void>(
      context: context,
      isShowBg: true,
      offset: const Offset(50.0, 150.0),
      anchor: hint,
      child: Semantics(
        label: '弹出引导页',
        hint: '向左滑动可删除列表，点击可关闭',
        button: true,
        child: Container(
          key: const Key('hint'),
          width: 200.0,
          height: 147.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ImageUtils.getAssetImage('goods/ydss'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        key: _hintKey,
        title: '商品规格',
        actionName: '保存',
        onPressed: () {
          Toast.show('保存');
          NavigatorUtils.goBack(context);
        },
      ),
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Gaps.vGap16,
          Text(
            _sizeName,
            style: AppTextStyles.textBold24,
          ),
          Gaps.vGap8,
          RichText(
            key: const Key('name_edit'),
            text: TextSpan(
              text: '先对名称进行',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontSize: AppDimens.font_sp14),
              children: <TextSpan>[
                TextSpan(
                  text: '编辑',
                  semanticsLabel: '编辑',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _showGoodsSizeDialog();
                    },
                ),
              ],
            ),
          ),
          Gaps.vGap32,
          Expanded(
            child: _goodsSizeList.isEmpty
                ? const StateLayout(
                    type: StateType.goods,
                    hintText: '暂无商品规格',
                  )
                : ListView.builder(
                    itemCount: _goodsSizeList.length,
                    itemExtent: 107.0,
                    itemBuilder: (_, index) => GoodsSizeItem(
                      index,
                      slidableController: _slidableController,
                      item: _goodsSizeList[index],
                    ),
                  ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: MyButton(
              onPressed: _isEdit
                  ? () {
                      NavigatorUtils.push(
                          context, GoodsRouter.goodsSizeEditPage);
                    }
                  : null,
              text: '添加',
            ),
          )
        ],
      ),
    );
  }

  void _showGoodsSizeDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GoodsSizeDialog(
          onPressed: (name) {
            setState(() {
              _sizeName = name;
              _isEdit = true;
            });
          },
        );
      },
    );
  }
}
