
import 'package:flutter/material.dart' hide TabBar,TabBarIndicatorSize,Tab,TabBarView;
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/home/provider/home_provider.dart';
import 'package:flutter_deer/order/page/order_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/page/my_fabu_task_quanbu.dart';
import 'package:flutter_deer/shop/page/my_fabu_user_task_page.dart';
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

/***
 * 我发布任务管理首页---已进行的任务列表--设置tab页
 */
class MyFabuUserTaskManagerHomeTab extends StatefulWidget {

  const MyFabuUserTaskManagerHomeTab({Key key,this.taskId}) : super(key: key);

  final int taskId;

  @override
  _MyFabuUserTaskManagerHomeTabState createState() => _MyFabuUserTaskManagerHomeTabState();
}

class _MyFabuUserTaskManagerHomeTabState extends State<MyFabuUserTaskManagerHomeTab> with AutomaticKeepAliveClientMixin<MyFabuUserTaskManagerHomeTab>, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive =>true;

  int tabIndex=1;
  final List<String> tabs = [
  ];
  final List<Widget> tabViews = [

  ];
  @override
  Widget build(BuildContext context) {
    tabs.add("全部");
    tabs.add("申请中");
    tabs.add("审核中");
    tabs.add("申诉中");
    tabs.add("已完成");
    tabViews.add(MyFabuUserTaskPage(status: -1,taskId: widget.taskId));
    tabViews.add(MyFabuUserTaskPage(status: 0,taskId: widget.taskId));
    tabViews.add(MyFabuUserTaskPage(status: 3,taskId: widget.taskId));
    tabViews.add(MyFabuUserTaskPage(status: 7,taskId: widget.taskId));
    tabViews.add(MyFabuUserTaskPage(status: 100,taskId: widget.taskId));

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
