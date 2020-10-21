import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/common/KeyValueItem.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/net/net.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/res/dimens.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/task/models/recommand_result_new_entity.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/zefyr_images.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';

/**
 * 发布任务的界面
 */
class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({Key key, this.taskId}) : super(key: key);

  final String taskId;

  @override
  _TaskDetailPage createState() => _TaskDetailPage();
}

class _TaskDetailPage extends State<TaskDetailPage> {
  ZefyrController _controller = ZefyrController(NotusDocument());

  FocusNode _focusNode = FocusNode();

  bool _editing = false;
  StreamSubscription<NotusChange> _sub;
  var doc = NotusDocument();
  RecommandResultNewEntity taskModel;

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
          centerTitle: "任务详情",
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
                      Text(
                        (taskModel == null) ? "" :taskModel.title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Gaps.vGap10,
                  Row(
                    children: [
                      Gaps.hGap16,
                      Text(
                        (taskModel == null) ? "用户id: " : "用户id: "+(taskModel.userid+10086).toString(),
                        style: TextStyle(
                            fontSize: 12),
                      ),
                      Gaps.hGap16,
                      Text(
                        (taskModel == null) ? "发布事件: " :  "发布事件: "+ taskModel.createTime,
                        style: TextStyle(
                            fontSize: 12),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Gaps.hGap16,
                      Text(
                        (taskModel == null) ? "剩余人数: " : "剩余人数: "+taskModel.createTime,
                        style: TextStyle(
                            fontSize: 12),
                      ),
                      Gaps.hGap16,
                      Text(
                        (taskModel == null) ? "" :  "发布事件: "+ taskModel.createTime,
                        style: TextStyle(
                            fontSize: 12),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ZefyrView(
                      document: doc,
                      imageDelegate: CustomImageDelegate(),
                    ),
                  ),
                  Material(
                    color: ThemeUtils.getBackgroundColor(context),
                    child: SafeArea(
                      child: Container(
                        height: 60.0,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              buttonTheme: ButtonThemeData(
                            height: 44.0,
                          )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
//                    Expanded(
//                    flex: 1,
//                    child: FlatButton(
//                    color: isDark ? Colours.dark_material_bg : const Color(0xFFE1EAFA),
//                    textColor: isDark ? Colours.dark_text : Colours.app_main,
//                    child: const Text(
//                    "拒单",
//                    style: TextStyle(
//                    fontSize: Dimens.font_sp18
//                    ),
//                    ),
//                    onPressed: (){},
//                    ),
//                    ),
//                    Gaps.hGap16,
                              Expanded(
                                flex: 1,
                                child: FlatButton(
                                  color: blue,
                                  textColor: isDark
                                      ? Colours.dark_button_text
                                      : Colors.white,
                                  child: const Text(
                                    "申请任务",
                                    style:
                                        TextStyle(fontSize: Dimens.font_sp18),
                                  ),
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Material(
                  color: ThemeUtils.getBackgroundColor(context),
                  child: SafeArea(
                    child: Container(
                      height: 0.0,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            buttonTheme: ButtonThemeData(
                          height: 44.0,
                        )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
//                    Expanded(
//                    flex: 1,
//                    child: FlatButton(
//                    color: isDark ? Colours.dark_material_bg : const Color(0xFFE1EAFA),
//                    textColor: isDark ? Colours.dark_text : Colours.app_main,
//                    child: const Text(
//                    "拒单",
//                    style: TextStyle(
//                    fontSize: Dimens.font_sp18
//                    ),
//                    ),
//                    onPressed: (){},
//                    ),
//                    ),
//                    Gaps.hGap16,
                            Expanded(
                              flex: 1,
                              child: FlatButton(
                                color: blue,
                                textColor: isDark
                                    ? Colours.dark_button_text
                                    : Colors.white,
                                child: const Text(
                                  "申请任务",
                                  style: TextStyle(fontSize: Dimens.font_sp18),
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ])));
  }

  //获取任务详情,并展示
  Future<void> _getServiceData() async {
    //NavigatorUtils.push(context, StoreRouter.auditPage);
    await DioUtils.instance.requestNetwork<RecommandResultNewEntity>(
        Method.post, HttpApi.getTaskById, onSuccess: (data) {
      Delta detail = Delta.fromJson(json.decode(data.content) as List);
      setState(() {
        taskModel = data;
        doc = NotusDocument.fromDelta(detail);
      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show(msg);
      });
    }, params: {"id": int.parse(widget.taskId)});
  }
}
