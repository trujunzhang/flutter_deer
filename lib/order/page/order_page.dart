import 'package:flutter/material.dart';
import 'package:flutter_deer/order/page/order_list_page.dart';
import 'package:flutter_deer/order/provider/order_page_provider.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/screen_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_card.dart';
import 'package:flutter_deer/widgets/my_flexible_space_bar.dart';
import 'package:provider/provider.dart';

import '../order_router.dart';
import 'widgets/SliverAppBarDelegate.dart';
import 'widgets/tab_view.dart';

/// design/3订单/index.html
class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with
        AutomaticKeepAliveClientMixin<OrderPage>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  TabController? _tabController;
  OrderPageProvider provider = OrderPageProvider();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      /// 预先缓存剩余切换图片
      _preCacheImage();
    });
  }

  void _preCacheImage() {
    precacheImage(ImageUtils.getAssetImage('order/xdd_n'), context);
    precacheImage(ImageUtils.getAssetImage('order/dps_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/dwc_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/ywc_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/yqx_s'), context);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    isDark = context.isDark;
    return ChangeNotifierProvider<OrderPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return NestedScrollView(
      key: const Key('order_list'),
      physics: const ClampingScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) =>
          _sliverBuilder(context),
      body: Container(),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          brightness: Brightness.dark,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                NavigatorUtils.push(context, OrderRouter.orderSearchPage);
              },
              tooltip: '搜索',
              icon: LoadAssetImage(
                'order/icon_search',
                width: 22.0,
                height: 22.0,
                color: ThemeUtils.getIconColor(context),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          expandedHeight: 100.0,
          floating: false,
          // 不随着滑动隐藏标题
          pinned: true,
          // 固定在顶部
          flexibleSpace: MyFlexibleSpaceBar(
            background: isDark
                ? Container(
                    height: 113.0,
                    color: AppColors.dark_bg_color,
                  )
                : LoadAssetImage(
                    'order/order_bg',
                    width: context.width,
                    height: 113.0,
                    fit: BoxFit.fill,
                  ),
            centerTitle: true,
            titlePadding:
                const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
            collapseMode: CollapseMode.pin,
            title: Text(
              '订单',
              style: TextStyle(color: ThemeUtils.getIconColor(context)),
            ),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          DecoratedBox(
            decoration: BoxDecoration(
              color: isDark ? AppColors.dark_bg_color : null,
              image: isDark
                  ? null
                  : DecorationImage(
                      image: ImageUtils.getAssetImage('order/order_bg1'),
                      fit: BoxFit.fill,
                    ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MyCard(
                child: Container(
                  height: 80.0,
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TabBar(
                    labelPadding: EdgeInsets.zero,
                    controller: _tabController,
                    labelColor:
                        context.isDark ? AppColors.dark_text : AppColors.text,
                    unselectedLabelColor: context.isDark
                        ? AppColors.dark_text_gray
                        : AppColors.text,
                    labelStyle: AppTextStyles.textBold14,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: AppDimens.font_sp14,
                    ),
                    indicatorColor: Colors.transparent,
                    tabs: const <Widget>[
                      TabView(0, '新订单'),
                      TabView(1, '待配送'),
                      TabView(2, '待完成'),
                      TabView(3, '已完成'),
                      TabView(4, '已取消'),
                    ],
                    onTap: (index) {
                      if (!mounted) {
                        return;
                      }
                      _pageController.jumpToPage(index);
                    },
                  ),
                ),
              ),
            ),
          ),
          80.0,
        ),
      ),
    ];
  }

  final PageController _pageController = PageController(initialPage: 0);

  Future<void> _onPageChange(int index) async {
    provider.setIndex(index);

    /// 这里没有指示器，所以缩短过渡动画时间，减少不必要的刷新
    _tabController?.animateTo(index, duration: Duration.zero);
  }
}
