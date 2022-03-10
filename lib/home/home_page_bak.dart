import 'package:flutter/material.dart';
import 'package:flutter_deer_djzhang/goods/page/goods_page.dart';
import 'package:flutter_deer_djzhang/home/provider/home_provider.dart';
// import 'package:flutter_deer_djzhang/order/page/order_page.dart';
import 'package:flutter_deer_djzhang/order/page/order_page_bak.dart';
import 'package:flutter_deer_djzhang/res/resources.dart';
import 'package:flutter_deer_djzhang/shop/page/shop_page.dart';
import 'package:flutter_deer_djzhang/statistics/page/statistics_page.dart';
import 'package:flutter_deer_djzhang/util/theme_utils.dart';
import 'package:flutter_deer_djzhang/widgets/double_tap_back_exit_app.dart';
import 'package:flutter_deer_djzhang/widgets/load_image.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with RestorationMixin {
  static const double _imageSize = 25.0;

  late List<Widget> _pageList;
  final List<String> _appBarTitles = ['订单', '商品', '统计', '店铺'];
  final PageController _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem>? _list;
  List<BottomNavigationBarItem>? _listDark;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void initData() {
    _pageList = [
      const OrderPage(),
      const GoodsPage(),
      const StatisticsPage(),
      const ShopPage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      const _tabImages = [
        [
          LoadAssetImage(
            'home/icon_order',
            width: _imageSize,
            color: AppColors.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_order',
            width: _imageSize,
            color: AppColors.app_main,
          ),
        ],
        [
          LoadAssetImage(
            'home/icon_commodity',
            width: _imageSize,
            color: AppColors.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_commodity',
            width: _imageSize,
            color: AppColors.app_main,
          ),
        ],
        [
          LoadAssetImage(
            'home/icon_statistics',
            width: _imageSize,
            color: AppColors.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_statistics',
            width: _imageSize,
            color: AppColors.app_main,
          ),
        ],
        [
          LoadAssetImage(
            'home/icon_shop',
            width: _imageSize,
            color: AppColors.unselected_item_color,
          ),
          LoadAssetImage(
            'home/icon_shop',
            width: _imageSize,
            color: AppColors.app_main,
          ),
        ]
      ];
      _list = List.generate(_tabImages.length, (i) {
        return BottomNavigationBarItem(
          icon: _tabImages[i][0],
          activeIcon: _tabImages[i][1],
          label: _appBarTitles[i],
        );
      });
    }
    return _list!;
  }

  List<BottomNavigationBarItem> _buildDarkBottomNavigationBarItem() {
    if (_listDark == null) {
      const _tabImagesDark = [
        [
          LoadAssetImage('home/icon_order', width: _imageSize),
          LoadAssetImage(
            'home/icon_order',
            width: _imageSize,
            color: AppColors.dark_app_main,
          ),
        ],
        [
          LoadAssetImage('home/icon_commodity', width: _imageSize),
          LoadAssetImage(
            'home/icon_commodity',
            width: _imageSize,
            color: AppColors.dark_app_main,
          ),
        ],
        [
          LoadAssetImage('home/icon_statistics', width: _imageSize),
          LoadAssetImage(
            'home/icon_statistics',
            width: _imageSize,
            color: AppColors.dark_app_main,
          ),
        ],
        [
          LoadAssetImage('home/icon_shop', width: _imageSize),
          LoadAssetImage(
            'home/icon_shop',
            width: _imageSize,
            color: AppColors.dark_app_main,
          ),
        ]
      ];

      _listDark = List.generate(_tabImagesDark.length, (i) {
        return BottomNavigationBarItem(
          icon: _tabImagesDark[i][0],
          activeIcon: _tabImagesDark[i][1],
          label: _appBarTitles[i],
        );
      });
    }
    return _listDark!;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return DoubleTapBackExitApp(
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: context.backgroundColor,
            items: isDark
                ? _buildDarkBottomNavigationBarItem()
                : _buildBottomNavigationBarItem(),
            type: BottomNavigationBarType.fixed,
            currentIndex: provider.value,
            elevation: 5.0,
            iconSize: 21.0,
            selectedFontSize: AppDimens.font_sp10,
            unselectedFontSize: AppDimens.font_sp10,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: isDark
                ? AppColors.dark_unselected_item_color
                : AppColors.unselected_item_color,
            onTap: (index) => _pageController.jumpToPage(index),
          ),
          // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
          body: PageView(
            physics: const NeverScrollableScrollPhysics(), // 禁止滑动
            controller: _pageController,
            onPageChanged: (int index) => provider.value = index,
            children: _pageList,
          )),
    );
  }

  @override
  String? get restorationId => 'home';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(provider, 'BottomNavigationBarCurrentIndex');
  }
}