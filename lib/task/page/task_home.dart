
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide TabBar,TabBarIndicatorSize,Tab,TabBarView;
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/order/provider/order_page_provider.dart';
import 'package:flutter_deer/order/widgets/order_item.dart';
import 'package:flutter_deer/order/widgets/order_item_tag.dart';
import 'package:flutter_deer/order/widgets/order_list.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/shop/page/shop_page.dart';
import 'package:flutter_deer/statistics/page/statistics_page.dart';
import 'package:flutter_deer/task/page/task_home_tab_recommand.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/my_refresh_list.dart';
import 'package:flutter_deer/widgets/search_bar.dart';
import 'package:flutter_deer/widgets/state_layout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_tab_bar.dart';
class TaskHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new TaskHomeStatePage();
  }

}

class TaskHomeStatePage extends State<TaskHomePage> with AutomaticKeepAliveClientMixin<TaskHomePage>, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive =>true;
  int tabIndex=0;
  final List<String> tabs = [
    "全部",
    "推荐",
    "程序员",
    "其他"
  ];
  final List<Widget> tabViews = [
    TaskHomeReCommandPage(),
    TaskHomeReCommandPage(),
    TaskHomeReCommandPage(),
    TaskHomeReCommandPage(),
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
//TabBar(
//indicatorSize: TabBarIndicatorSize.label,
//labelColor: Colours.app_main,
//labelStyle: TextStyle(
//fontSize: 18,
//fontWeight: FontWeight.bold
//),
//unselectedLabelStyle: TextStyle(
//fontSize: 14,
////fontWeight: FontWeight.bold
//),
//unselectedLabelColor: Colors.grey,
//indicatorColor: Colours.app_main,
//isScrollable: true, //设置为可以滚动
//tabs: tabs.map((String title) {
//return new Container(
//height: 35,
//child: Tab(
//text: title,
//),
//);
//}).toList(),
//),
class CommonWidgetTabBar extends StatefulWidget {
  @override
  _CommonWidgetTabBarState createState() => _CommonWidgetTabBarState();
}

class _CommonWidgetTabBarState extends State<CommonWidgetTabBar> {
  int tabIndex = 0;  // 当前选中索引
  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: (index){
        // 每当TabBar 切换更新索引
        setState(() {
          tabIndex = index;
        });
      },
      isScrollable: true, // 是否滚动
      unselectedLabelColor: Colors.black54, //未选中颜色
      labelColor: Colors.blue, //选中颜色
      // labelStyle: TextStyle(fontSize: 20.0),
      // unselectedLabelStyle: TextStyle(fontSize: 16.0),
      tabs: [
        Tab(child: Text('我的',style: TextStyle(fontSize: tabIndex == 0 ? 20:16),)),  // 如果当前索引等于0字体大小就是20
        Tab(child: Text('我的',style: TextStyle(fontSize: tabIndex == 1 ? 20:16),)),
        Tab(child: Text('我的',style: TextStyle(fontSize: tabIndex == 2 ? 20:16),)),
        Tab(child: Text('我的',style: TextStyle(fontSize: tabIndex == 3 ? 20:16),)),
        Tab(child: Text('我的',style: TextStyle(fontSize: tabIndex == 4 ? 20:16),)),
        Tab(child: Text('我的',style: TextStyle(fontSize: tabIndex == 5 ? 20:16),)),
      ],
    );
  }
}