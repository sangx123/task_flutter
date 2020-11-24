
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart' hide MyAppBar;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/common/KeyValueItem.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/net/net.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/res/dimens.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/shop_router.dart';
import 'package:flutter_deer/task/models/home_task_list_entity.dart';
import 'package:flutter_deer/task/models/recommand_result_new_entity.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/util/zefyr_images.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';



///商户审核用户提交的任务界面
class BusinessFirstAduitPage extends StatefulWidget {
  const BusinessFirstAduitPage({Key key, this.userTaskId}) : super(key: key);

  final String userTaskId;

  @override
  _BusinessFirstAduitPage createState() => _BusinessFirstAduitPage();
}

class _BusinessFirstAduitPage extends State<BusinessFirstAduitPage> {
  ZefyrController _controller = ZefyrController(NotusDocument());

  FocusNode _focusNode = FocusNode();

  bool _editing = false;
  StreamSubscription<NotusChange> _sub;
  var doc = NotusDocument();
  HomeTaskListUserTaskList userTaskModel;

  @override
  void initState() {
    super.initState();
    _getServiceData();
    _sub = _controller.document.changes.listen((change) {
      print('${change.source}: ${change.change}');
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);

    Color red = Theme.of(context).errorColor;
    Color blue = Theme.of(context).primaryColor;
//
//    final theme = ZefyrThemeData(
//      cursorColor: Colors.blue,
//      toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
//        color: Colors.grey.shade800,
//        toggleColor: Colors.grey.shade900,
//        iconColor: Colors.white,
//        disabledIconColor: Colors.grey.shade500,
//      ),
//    );
//    return Scaffold(
//      resizeToAvoidBottomPadding: true,
//      appBar: MyAppBar(
//        centerTitle: "任务详情",
//        actionName: "",
//        onPressed: () => {},
//      ),
//      body: ZefyrScaffold(
//        child: ZefyrTheme(
//          data: theme,
//          child:
//
//          ListView(
//              children: <Widget>[
//              Text('输入标题：'),
//          ZefyrField(
//            controller: _controller,
//            focusNode: _focusNode,
//            mode: _editing ? ZefyrMode.edit : ZefyrMode.select,
//            imageDelegate: CustomImageDelegate(),
//          ),]
//        ),
//      )
//    )
//    );

    final theme = ZefyrThemeData(
      toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
        color: Colors.grey.shade800,
        toggleColor: Colors.grey.shade900,
        iconColor: Colors.white,
        disabledIconColor: Colors.grey.shade500,
      ),
    );
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: MyAppBar(
          centerTitle: "审核任务",
          actionName: "",
          onPressed: () => {},
        ),
        body: ZefyrTheme(
            data: theme,
            child: Stack(children: <Widget>[
              ListView(
                children: <Widget>[
                  Gaps.vGap10,
                  Row(
                    children: [
                      Gaps.hGap16,
                      Expanded(child: Text(
                        (userTaskModel==null)?"":userTaskModel.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),

                      Gaps.hGap16,
                    ],
                  ),
                  Gaps.vGap10,
                  Row(
                    children: [
                      Gaps.hGap16,
                      Expanded(child: Text(
                        (userTaskModel==null)?"任务提交时间: ":"任务提交时间: "+userTaskModel.userFirstSubmitTaskTime,
                        style: TextStyle(
                            fontSize: 14,),
                      )),
                      Gaps.hGap16,
                    ],
                  ),
                  Gaps.vGap10,
//                  Gaps.line10,
//                  Gaps.vGap5,
//                  Row(
//                    children: [
//                      Gaps.hGap16,
//                      Text(
//                        (taskModel == null) ? "用户id: " : "用户id: "+(taskModel.userid+10086).toString(),
//                        style: TextStyle(
//                            fontSize: 14),
//                      ),
//                      Gaps.hGap16,
//
//                    ],
//                  ),
//                  Gaps.vGap5,
//                  Row(
//                    children: [
//                      Gaps.hGap16,
//                      Text(
//                        (taskModel == null) ? "任务发布时间: " :  "任务发布时间: "+ taskModel.createTime,
//                        style: TextStyle(
//                            fontSize: 14),
//                      ),
//                      Gaps.hGap16,
//
//                    ],
//                  ),
                  Gaps.vGap5,
                  Gaps.line10,
                  Gaps.vGap5,
                  Row(
                    children: [
                      Gaps.hGap16,
                      Text(
                        "用户提交内容:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:16,top:10, right:16,bottom: 70),
                    child: ZefyrView(
                      document: doc,
                      imageDelegate: CustomImageDelegate(),
                    ),
                  ),
//                  Material(
//                    color: ThemeUtils.getBackgroundColor(context),
//                    child: SafeArea(
//                      child: Container(
//                        height: 60.0,
//                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                        child: Theme(
//                          data: Theme.of(context).copyWith(
//                              buttonTheme: ButtonThemeData(
//                            height: 44.0,
//                          )),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Expanded(
//                                flex: 1,
//                                child: FlatButton(
//                                  color: blue,
//                                  textColor: isDark
//                                      ? Colours.dark_button_text
//                                      : Colors.white,
//                                  child: const Text(
//                                    "申请任务",
//                                    style:
//                                        TextStyle(fontSize: Dimens.font_sp18),
//                                  ),
//                                  onPressed:  applyTask,
//                                ),
//                              )
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  )
                ],
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: isShowButtom()?Material(
                  color: ThemeUtils.getBackgroundColor(context),
                  child: SafeArea(
                    child: Container(
                      height: 60.0,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16),
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
                                  "不通过",
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
                                  "通过",
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
                ): Container(),
              )
            ])));
  }

//  /// 点击申请任务
//  Future<void> applyTask() async {
//    await DioUtils.instance.requestNetwork<String>(
//      Method.post,
//      HttpApi.applyTask,
//      onSuccess: (data) {
//        Toast.show("申请成功");
//      },
//      onError: (code, msg) {
//        Toast.show(msg);
//      },
//      params: {"taskid":int.parse(widget.taskId)},
//    );
//  }
  ///显示剩余申请人数
//  String getPeoPleNum() {
//    if(taskModel==null){
//      return "";
//    }else{
//      if(taskModel.userTaskList.isEmpty){
//        return taskModel.needpeoplenum.toString();
//      }else{
//        int applyedNum=0;
//        for(int i=0;i<taskModel.userTaskList.length;i++){
//          if(taskModel.userTaskList[i].userTaskStatus>0){
//            applyedNum++;
//          }
//        }
//        return (taskModel.needpeoplenum-applyedNum).toString();
//      }
//    }
//
//  }

  bool isShowButtom() {
    return true;
//    if(taskModel==null)return false;//如果没取到数据不显示
//    if(taskModel.userid.toString()== SpUtil.getString(Constant.userId)){
//      return false;
//    }else{
//      return true;
//    }
  }

  ///获取任务详情,并展示
  Future<void> _getServiceData() async {
    //NavigatorUtils.push(context, StoreRouter.auditPage);
    await DioUtils.instance.requestNetwork<HomeTaskListUserTaskList>(
        Method.post, HttpApi.getUserTaskById, onSuccess: (data) {
      Delta detail = Delta.fromJson(json.decode(data.userFirstSubmitTaskContent) as List);
      setState(() {
        userTaskModel=data;
        doc = NotusDocument.fromDelta(detail);
      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show(msg);
      });
    }, params: {"id": widget.userTaskId});
  }


  Future<void> ApplyOk() async{
    await DioUtils.instance.requestNetwork<String>(
      Method.post,
      HttpApi.businessAuditFirstSubmit,
      onSuccess: (data) {
        Toast.show(data);
      },
      onError: (code, msg) {
        Toast.show(msg);
      },
      params: {"id":int.parse(widget.userTaskId),"agree":true},
    );
  }

  Future<void> ApplyNo() async{
     //跳转到编辑原因
    NavigatorUtils.push(context, '${ShopRouter.businessFirstAuditFailReasonPage}?userTaskId=${widget.userTaskId}');
  }
}





