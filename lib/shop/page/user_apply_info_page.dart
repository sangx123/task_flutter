import 'package:flutter/material.dart';
import 'package:flutter_deer/net/dio_utils.dart';
import 'package:flutter_deer/net/http_api.dart';
import 'package:flutter_deer/order/order_router.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/task/models/home_task_list_entity.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';

import '../../config.dart';

/// design/3订单/index.html#artboard10
class UserApplyInfoPage extends StatefulWidget {
  const UserApplyInfoPage({Key key, this.userTaskId}) : super(key: key);

  final String userTaskId;

  @override
  _UserApplyInfoPageState createState() => _UserApplyInfoPageState();
}

class _UserApplyInfoPageState extends State<UserApplyInfoPage> {
  HomeTaskListUserTaskList model;

  @override
  void initState() {
    super.initState();
    _getServiceData();
  }

  @override
  Widget build(BuildContext context) {
    Color red = Theme.of(context).errorColor;
    Color blue = Theme.of(context).primaryColor;

    Color _backgroundColor;
    Color _shadowColor;
    bool isDark = ThemeUtils.isDark(context);
    _backgroundColor = isDark ? Colours.dark_bg_gray_ : Colors.white;
    _shadowColor = isDark ? Colors.transparent : const Color(0xFFF1F1F1);
    return Scaffold(
      appBar: MyAppBar(
        title: "任务详情",
        onPressed: () {
          NavigatorUtils.push(context, OrderRouter.orderTrackPage);
        },
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
              key: const Key('order_info'),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: _backgroundColor,
                            border: Border(
                              bottom: Divider.createBorderSide(context,
                                  width: 1, color: _shadowColor),
                            )),
                        child: Container(
                          padding: const EdgeInsets.only(top: 16,bottom: 16),
                          child: InkWell(
                            onTap: () => Config.goNext(context, model),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Gaps.hGap8,
                                    Expanded(
                                      // 合并Text的语义
                                      child: MergeSemantics(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              (model==null||model.name==null)?"":model.name,
                                              style: TextStyle(
                                                  fontSize: Dimens.font_sp16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Gaps.vGap8,
                                            Text((model==null)?"":Config.getTaskStatusTime(model)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    //Gaps.hGap16,
                                    Text(
                                      (model==null)?"":Config.getTaskStatus(
                                          model.userTaskStatus.toString()),
                                      style: TextStyle(
                                          fontSize: Dimens.font_sp16,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).errorColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Gaps.vGap50,
                      Gaps.vGap50
                      ,

                      Text("忽略：忽略后用户将被移除用户申请列表"),
                      Text("同意：同意后用户直接进行任务"),
                      Gaps.vGap16
                      ,
                      Material(
                        color: ThemeUtils.getBackgroundColor(context),
                        child: SafeArea(
                          child: Container(
                            height: 60.0,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  buttonTheme: ButtonThemeData(
                                height: 44.0,
                              )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: FlatButton(
                                      color: isDark
                                          ? Colours.dark_material_bg
                                          : const Color(0xFFE1EAFA),
                                      textColor: isDark
                                          ? Colours.dark_text
                                          : Colours.app_main,
                                      child: const Text(
                                        "忽略",
                                        style: TextStyle(
                                            fontSize: Dimens.font_sp18),
                                      ),
                                      onPressed: ApplyNo,
                                    ),
                                  ),
                                  Gaps.hGap16,
                                  Expanded(
                                    flex: 1,
                                    child: FlatButton(
                                      color: blue,
                                      textColor: isDark
                                          ? Colours.dark_button_text
                                          : Colors.white,
                                      child: const Text(
                                        "同意",
                                        style: TextStyle(
                                            fontSize: Dimens.font_sp18),
                                      ),
                                      onPressed: ApplyOk,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(),
          )
        ],
      ),
    );
  }


  ///获取任务详情,并展示
  Future<void> _getServiceData() async {
    //NavigatorUtils.push(context, StoreRouter.auditPage);
    await DioUtils.instance.requestNetwork<HomeTaskListUserTaskList>(
        Method.post, HttpApi.getUserTaskById, onSuccess: (data) {
      setState(() {
        model = data;
      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show(msg);
      });
    }, params: {"id": widget.userTaskId});
  }

  Future<void> ApplyOk() async{
    await DioUtils.instance.requestNetwork<String>(
        Method.post, HttpApi.isBusinessAllowUserTask, onSuccess: (data) {
      setState(() {
        Toast.show(data);
      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show(msg);
      });
    }, params: {"id": widget.userTaskId,"agree":true});

  }
  Future<void> ApplyNo() async{
    await DioUtils.instance.requestNetwork<String>(
        Method.post, HttpApi.isBusinessAllowUserTask, onSuccess: (data) {
      setState(() {
        Toast.show(data);
      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show(msg);
      });
    }, params: {"id": widget.userTaskId,"agree":false});

  }
}
