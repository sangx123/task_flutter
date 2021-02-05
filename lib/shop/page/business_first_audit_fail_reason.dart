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
import 'package:flutter_deer/util/file_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/zefyr_images.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/text_field.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';

import '../shop_router.dart';
/**
 * 审核失败填写失败原因
 */
class BusinessFirstAuditFailReasonPage extends StatefulWidget {

  const BusinessFirstAuditFailReasonPage({Key key, this.userTaskId}) : super(key: key);

  final String userTaskId;
  @override
  _BusinessFirstAuditFailReasonPageState createState() => _BusinessFirstAuditFailReasonPageState();
}

class _BusinessFirstAuditFailReasonPageState extends State<BusinessFirstAuditFailReasonPage> {
  ZefyrController _controller =
  ZefyrController(NotusDocument());
  FocusNode _focusNode = FocusNode();

  bool _editing = true;
  StreamSubscription<NotusChange> _sub;

  @override
  void initState() {
    super.initState();
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
      //resizeToAvoidBottomPadding: true,
      appBar:  MyAppBar(
        centerTitle: "填写不通过原因",
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

  void _saveDocument(BuildContext context) async{
    _editing = false;
    final contents = jsonEncode(_controller.document);
    Delta list = Delta.fromJson(json.decode(contents) as List);
    List<KeyValueItem> imageList = new List<KeyValueItem>();
    for (var item in list.toList()) {
      if (item.attributes != null && item.attributes.containsKey("embed")) {
        if (item.attributes["embed"]["type"] == "image") {
          var path = item.attributes["embed"]["source"].toString();
          var name =
          path.toString().substring(path.toString().lastIndexOf("/") + 1);
          var model = KeyValueItem();
          model.key = name;
          model.value = path;
          imageList.add(model);
          //MultipartFile multipartFile =  await MultipartFile.fromFile(path, filename:name);
        }
      }
    }

    List<MultipartFile> multipartImageList = new List<MultipartFile>();
    for (KeyValueItem item in imageList) {
      MultipartFile multipartFile = MultipartFile.fromBytes(
        await MFileUtils.readFileByte(item.value), //图片路径
        filename: item.key, //图片名称
      );
      print("读取" + item.key + "完毕");
      multipartImageList.add(multipartFile);
    }
    print("读取MultipartFile完毕");
    FormData formData = FormData.fromMap({
      "id": widget.userTaskId,
      "imageList": multipartImageList,
      "agree":false,
      "content":contents
    });

    //NavigatorUtils.push(context, StoreRouter.auditPage);
    await DioUtils.instance.requestNetwork<String>(
      Method.post,
      HttpApi.businessAuditFirstSubmit,
      onSuccess: (data) {
        Toast.show(data);
        NavigatorUtils.goBack(context);
      },
      onError: (code, msg) {
        Toast.show(msg);
      },
      params: formData,
    );


//    await DioUtils.instance.requestNetwork<String>(
//      Method.post,
//      HttpApi.businessAuditFirstSubmit,
//      onSuccess: (data) {
//        Toast.show(data);
//        NavigatorUtils.goBack(context);
//      },
//      onError: (code, msg) {
//        Toast.show(msg);
//      },
//      params: {"id":int.parse(widget.userTaskId),"agree":false,"reason":contents},
//    );

    return ;

//    print(Directory.systemTemp.path);
//    // For this example we save our document to a temporary file.
//    final file = File(Directory.systemTemp.path + "/quick_start.json");
//    // And show a snack bar on success.
//    file.writeAsString(contents).then((_) {
//      //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saved.")));
//    });
//    setState(() {
//      //刷新界面
//    });
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
}