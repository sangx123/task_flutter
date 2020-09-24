
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
class TaskHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new TaskHomeStatePage();
  }

}

class TaskHomeStatePage extends State<TaskHomePage> with AutomaticKeepAliveClientMixin<TaskHomePage>, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive =>true;
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
        appBar: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colours.app_main,
          labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
          unselectedLabelStyle: TextStyle(
          fontSize: 17,
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