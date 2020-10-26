
import 'package:flutter/material.dart' hide TabBar,TabBarIndicatorSize,Tab,TabBarView;
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/home/provider/home_provider.dart';
import 'package:flutter_deer/order/page/order_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/page/my_fabu_task_quanbu.dart';
import 'package:flutter_deer/shop/page/shop_page.dart';
import 'package:flutter_deer/statistics/page/statistics_page.dart';
import 'package:flutter_deer/task/page/task_home.dart';
import 'package:flutter_deer/task/task_router.dart';
import 'package:flutter_deer/task/widgets/custom_tab_bar.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class MyFabuTaskManagerHomeTab extends StatefulWidget {
  @override
  _MyFabuTaskManagerHomeTabState createState() => _MyFabuTaskManagerHomeTabState();
}

class _MyFabuTaskManagerHomeTabState extends State<MyFabuTaskManagerHomeTab> with AutomaticKeepAliveClientMixin<MyFabuTaskManagerHomeTab>, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive =>true;

  int tabIndex=1;
  final List<String> tabs = [
    "进行中",
    "已完成"
  ];
  final List<Widget> tabViews = [
    MyFabuTaskQuanbuPage(status: 3),
    MyFabuTaskQuanbuPage(status: 4)
  ];
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: tabs.length,
      initialIndex: 0, //默认选中
      child: Scaffold(
        appBar:
        TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colours.app_main,
          labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 15,
            //fontWeight: FontWeight.bold
          ),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colours.app_main,
          isScrollable: true, //设置为可以滚动
          tabs: tabs.map((String title) {
            return new Container(
              height: 35,
              child: Tab(
                text: title,
              ),
            );
          }).toList(),
        ),
        body: TabBarView(
          children: tabViews,
        ),
      ),
    );
  }
}
