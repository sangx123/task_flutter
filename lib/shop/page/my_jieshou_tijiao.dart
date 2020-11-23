import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/common/KeyValueItem.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/net/net.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/res/styles.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/zefyr_images.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/text_field.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';
/**
 * 我接受的任务提交的任务的证据
 */
class MyJieShouTiJiaoPage extends StatefulWidget {

  const MyJieShouTiJiaoPage({Key key, this.userTaskId,this.content}) : super(key: key);

  final String userTaskId;
  final String content;
  @override
  _MyJieShouTiJiaoPageState createState() => _MyJieShouTiJiaoPageState();
}

class _MyJieShouTiJiaoPageState extends State<MyJieShouTiJiaoPage> {
  ZefyrController _controller =
  ZefyrController(NotusDocument());
  FocusNode _focusNode = FocusNode();

  bool _editing = true;
  StreamSubscription<NotusChange> _sub;

  @override
  void initState() {
    super.initState();

    //requestBook();
//    _loadDocument().then((document) {
//      setState(() {
//        _controller = ZefyrController(document);
//      });
//    });
      if(widget.content!=null&&widget.content.isNotEmpty) {
        _loadDocument().then((document) {
          setState(() {
            _controller = ZefyrController(document);
          });
        });
      }
      _sub = _controller.document.changes.listen((change) {
        print('${change.source}: ${change.change}');
      });

  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
  TextEditingController _nameController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar:  MyAppBar(
        centerTitle: "提交任务",
        actionName: "提交",
        onPressed:()=> _saveDocument(context),
      ),
      body: _buildBody()
//      defaultTargetPlatform == TargetPlatform.iOS ? FormKeyboardActions(
//        child: _buildBody(),
//      ) : SingleChildScrollView(
//        child: _buildBody(),
//      )
    );
  }

  void _startEditing() {
    setState(() {
      _editing = true;
    });
  }

  void _stopEditing() {
    setState(() {
      _editing = false;
    });
  }


//  /// Loads the document asynchronously from a file if it exists, otherwise
//  /// returns default document.
//  Future<NotusDocument> _loadDocument() async {
////    final file = File(Directory.systemTemp.path + "/quick_start.json");
////    if (await file.exists()) {
////      final contents = await file
////          .readAsString()
////          .then((data) => Future.delayed(Duration(seconds: 1), () => data));
////      if(contents.isNotEmpty)
////      return NotusDocument.fromJson(jsonDecode(contents));
////    }
////    final Delta delta = Delta();
////    return NotusDocument.fromDelta(delta);
//    final doc =r'[{"insert":"​","attributes":{"embed":{"type":"image","source":"http://192.168.0.127/20200917153242804.jpg"}}},{"insert":"\n9666\n"},{"insert":"​","attributes":{"embed":{"type":"image","source":"http://192.168.0.127/20200917153242880.jpg"}}},{"insert":"\n0000\n"}]';
//    Delta detail= Delta.fromJson(json.decode(doc) as List);
//    return NotusDocument.fromDelta(detail);
//  }

  Future<void> _saveDocument(BuildContext context) async{
    final contents = jsonEncode(_controller.document);
    await DioUtils.instance.requestNetwork<String>(
      Method.post,
      HttpApi.userTaskFirstSubmit,
      onSuccess: (data) {
        Toast.show(data);
      },
      onError: (code, msg) {
        Toast.show(msg);
      },
      params: {"id":int.parse(widget.userTaskId),"content":contents},
    );
  }


  _buildBody() {
    final theme = ZefyrThemeData(
      cursorColor: Colors.blue,
      toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
        color: Colors.grey.shade800,
        toggleColor: Colors.grey.shade900,
        iconColor: Colors.white,
        disabledIconColor: Colors.grey.shade500,
      ),
    );

     return ZefyrScaffold(
                    child: ZefyrTheme(
                      data: theme,
                      child: ZefyrEditor(
                        controller: _controller,
                        focusNode: _focusNode,
                        mode: _editing ? ZefyrMode.edit : ZefyrMode.select,
                        imageDelegate: CustomImageDelegate(),
                      ),
                    ),
                  );
//    return
//
//        Column(
//            mainAxisSize:MainAxisSize.max,
//        children: <Widget>[
//          MyTextField(
//            key: const Key('phone'),
//            focusNode: _nodeText1,
//            controller: _nameController,
//            maxLength: 11,
//            keyboardType: TextInputType.phone,
//            hintText: "请输入标题",
//          ),
//          Expanded(
//            flex: 1,
//             child: Container(
//                  color: Colors.red,
//                  height: 300,
//                ),)
////          Expanded(
////
////                child: Container(
////                  color: Colors.red,
////
////                ),
//////                child:ZefyrScaffold(
//////                    child: ZefyrTheme(
//////                      data: theme,
//////                      child: ZefyrEditor(
//////                        controller: _controller,
//////                        focusNode: _focusNode,
//////                        mode: _editing ? ZefyrMode.edit : ZefyrMode.select,
//////                        imageDelegate: CustomImageDelegate(),
//////                      ),
//////                    ),
//////                  )
////              ),
//        ]);

  }


  /// Loads the document asynchronously from a file if it exists, otherwise
  /// returns default document.
  Future<NotusDocument> _loadDocument() async {
//    final file = File(Directory.systemTemp.path + "/quick_start.json");
//    if (await file.exists()) {
//      final contents = await file
//          .readAsString()
//          .then((data) => Future.delayed(Duration(seconds: 1), () => data));
//      if(contents.isNotEmpty)
//      return NotusDocument.fromJson(jsonDecode(contents));
//    }
//    final Delta delta = Delta();
//    return NotusDocument.fromDelta(delta);
    //final doc = r'[{"insert":"​","attributes":{"embed":{"type":"image","source":"http://192.168.0.127/20200917153242804.jpg"}}},{"insert":"\n9666\n"},{"insert":"​","attributes":{"embed":{"type":"image","source":"http://192.168.0.127/20200917153242880.jpg"}}},{"insert":"\n0000\n"}]';
    Delta detail = Delta.fromJson(json.decode(widget.content) as List);
    return NotusDocument.fromDelta(detail);
  }
}