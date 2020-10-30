import 'package:dio/dio.dart';
import 'package:flutter/material.dart'
    hide TabBar, TabBarIndicatorSize, Tab, TabBarView;
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/order/provider/order_page_provider.dart';
import 'package:flutter_deer/order/widgets/order_item.dart';
import 'package:flutter_deer/order/widgets/order_item_tag.dart';
import 'package:flutter_deer/order/widgets/order_list.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/page/shop_page.dart';
import 'package:flutter_deer/statistics/page/statistics_page.dart';
import 'package:flutter_deer/store/store_router.dart';
import 'package:flutter_deer/task/page/task_home_tab_recommand.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_refresh_list.dart';
import 'package:flutter_deer/widgets/search_bar.dart';
import 'package:flutter_deer/widgets/state_layout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:tobias/tobias.dart';

import '../widgets/custom_tab_bar.dart';

class TaskPayPage extends StatefulWidget {
  const TaskPayPage({Key key, this.pay,this.price}) : super(key: key);

  final String pay;
  final String price;
  @override
  State<StatefulWidget> createState() {
    return new TaskPayStatePage();
  }
}

var chose = true;

class TaskPayStatePage extends State<TaskPayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          centerTitle: "订单支付",
        ),
        body: Column(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Gaps.vGap30,
                    Center(
                      child: Container(
                        child: Image.asset("assets/images/ic_launcher.png"),
                        width: 101,
                        height: 101,
                      ),
                    ),
                    Gaps.vGap10,
                    Center(
                      child: Text("您需要支付"),
                    ),
                    Gaps.vGap10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("￥",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold)),
                        Text(widget.price,
                            style: TextStyle(
                                fontSize: 36, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Gaps.vGap30,
                    Container(width: double.infinity, height: 1.0, color: Color(0xFFF3F3F3),),
                    Gaps.vGap10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        Gaps.hGap16,
                        Text("支付方式" ,style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    Gaps.vGap10,
                    Row(children: [
                      Gaps.hGap16,
                      Expanded(
                        flex: 1,
                        child: Container(height: 1.0, color: Color(0xFFF3F3F3),),)

                    ],),
                    Gaps.vGap10,
                    InkWell(
                        onTap: () {
                          chose = !chose;
                          //setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, right: 5),
                              child: Container(
                                child: Image.asset(
                                    "assets/images/alipay_logo.png"),
                                width: 36,
                                height: 36,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text("支付宝", style: TextStyle(fontSize: 15)),
                                  Gaps.hGap5,
                                  Container(
                                    child: Image.asset(
                                        "assets/images/alipay_recommand.png"),
                                    width: 27,
                                    height: 15,
                                  ),
                                ]),
                                Text("10亿人都在用，真安全，更方便",
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xFFCCCCCC))),
                              ],
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Container(
                                width: 25,
                                height: 25,
                                child: chose
                                    ? Image.asset("assets/images/ic_chosed.png")
                                    : Image.asset(
                                        "assets/images/ic_no_chose.png")),
                            Gaps.hGap16
                          ],
                        )),
                    Gaps.vGap10,
                    Container(width: double.infinity, height: 1.0, color: Color(0xFFF3F3F3),),

                  ],
                )),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: MyButton(
                onPressed: () {
                  //_createTask();
                  //NavigatorUtils.goBack(context);
                  callAlipay(widget.pay);
                },
                text: "立即支付",
              ),
            )
          ],
        ));
  }

  callAlipay(String _payInfo) async {
    Map payResult;
    try {
      print("The pay info is : " + _payInfo);
      payResult = await aliPay(_payInfo);
      if(payResult["resultStatus"]=="9000"){
        Toast.show("支付成功");
        NavigatorUtils.push(context, StoreRouter.auditResultPage);
      }else{
        Toast.show("支付失败");
      }

    } on Exception catch (e) {
      payResult = {};
    }

    if (!mounted) return;

    setState(() {
      //_payResult = payResult;
    });
  }
}
