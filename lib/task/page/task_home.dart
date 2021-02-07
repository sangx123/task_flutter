
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide TabBar,TabBarIndicatorSize,Tab,TabBarView;
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/net/dio_utils.dart';
import 'package:flutter_deer/net/http_api.dart';
import 'package:flutter_deer/order/provider/order_page_provider.dart';
import 'package:flutter_deer/order/widgets/order_item.dart';
import 'package:flutter_deer/order/widgets/order_item_tag.dart';
import 'package:flutter_deer/order/widgets/order_list.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/shop/page/shop_page.dart';
import 'package:flutter_deer/statistics/page/statistics_page.dart';
import 'package:flutter_deer/task/models/task_main_type_model_entity.dart';
import 'package:flutter_deer/task/page/task_home_tab_recommand.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/my_refresh_list.dart';
import 'package:flutter_deer/widgets/search_bar.dart';
import 'package:flutter_deer/widgets/state_layout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_deer/util/image_utils.dart';
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
  int tabIndex=1;

  bool showNetError=false;
  final List<String> tabs = [
  ];
  final List<Widget> tabViews = [
  ];

  @override
  void initState() {
    super.initState();
    _getMainType();
  }


  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: tabs.length,
      initialIndex: 0, //默认选中
      child: showNetError?InkWell(
        child: Center(
          child: StateLayout(type:StateType.network),
        ),
        onTap:(){
          print('CALL');
          _getMainType();
        },
      ):Scaffold(
        appBar: TabBar(
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

//        Container(
//          width: double.infinity,
//          child: Column(
//            children: <Widget>[
//              Opacity(
//                opacity: showNetError?1:0,//0.0 到 1.0，0.0表示完全透明，1.0表示完全不透明
//                child: Container(
//                  height: 120.0,
//                  width: 120.0,
//                  decoration: BoxDecoration(
//                    image: DecorationImage(
//                      image: ImageUtils.getAssetImage("state/zwwl"),
//                    ),
//                  ),
//                ))
//            ,
//
//            ],
//          ),
//        ),


      ),
    );
  }

  //此处通过网络请求获取tab并展示对应的tab栏

  ///下拉刷新
  Future<void> _getMainType() async {
    await DioUtils.instance.requestNetwork<TaskMainTypeModelEntity>(
        Method.post, HttpApi.getTaskMainType, isList: true, onSuccessList: (data) {
      setState(() {
        showNetError=false;
        initData(data);
      });
    }, onError: (code, msg) {
      setState(() {
        showNetError=true;
        Toast.show(msg);
      });
    }, params: {});
  }

  void initData(List<TaskMainTypeModelEntity> data) {
      for(int i=0;i<data.length;i++){
        tabs.add(data[i].name);
        tabViews.add(TaskHomeReCommandPage(type: data[i].id));
      }

  }

}