
import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/home/provider/home_provider.dart';
import 'package:flutter_deer/order/page/order_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/page/shop_page.dart';
import 'package:flutter_deer/statistics/page/statistics_page.dart';
import 'package:flutter_deer/task/page/task_home.dart';
import 'package:flutter_deer/task/task_router.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/search_bar.dart';
import 'package:provider/provider.dart';

import 'my_fabu_task_manager_home_tab.dart';

class MyFabuTaskManagerHome extends StatefulWidget {
  @override
  _MyFabuTaskManagerHomeState createState() => _MyFabuTaskManagerHomeState();
}

class _MyFabuTaskManagerHomeState extends State<MyFabuTaskManagerHome> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: const MyAppBar(
            centerTitle: "我发布的任务",
            hasLine: false,
          ),
          body: MyFabuTaskManagerHomeTab()
        );

  }
}
