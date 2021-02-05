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
 * 发布任务的界面
 */
class PublishTaskPage extends StatefulWidget {

  const PublishTaskPage({Key key, this.content}) : super(key: key);

  final String content;
  @override
  _PublishTaskState createState() => _PublishTaskState();
}

class _PublishTaskState extends State<PublishTaskPage> {
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
      if(widget.content.isNotEmpty) {
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
      //resizeToAvoidBottomPadding: true,
      appBar:  MyAppBar(
        centerTitle: "编辑任务内容",
        actionName: "完成",
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
    NavigatorUtils.goBackWithParams(context,contents);
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

  Future<void> _createTask(List<KeyValueItem> imageList,String contents)  async {
//    _readFileByte(Directory.systemTemp.path + "/quick_start.json").then((bytesData) async {
//
//
//
//    });
    //do your task here

    List<MultipartFile> multipartImageList = new List<MultipartFile>();
      for(KeyValueItem item in imageList){
        MultipartFile multipartFile = MultipartFile.fromBytes(
          await _readFileByte(item.value),                    //图片路径
          filename: item.key,            //图片名称
        );
        print("读取"+item.key+"完毕");
        multipartImageList.add(multipartFile);
      }
    print("读取MultipartFile完毕");
    FormData formData = FormData.fromMap({
      "imageList": multipartImageList,
      "content" : contents,
    });

    //NavigatorUtils.push(context, StoreRouter.auditPage);
    await DioUtils.instance.requestNetwork<String>(
      Method.post, HttpApi.createTask,
      onSuccess: (data){
        Toast.show('任务创建成功！');
      },
      onError: (code,msg){
        Toast.show(msg);
      },
      params: formData,
    );



  }

  Future<Uint8List> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = new File.fromUri(myUri);
    Uint8List bytes;
    await audioFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      print('reading of bytes is completed');
    }).catchError((onError) {
      print('Exception Error while reading audio from path:' +
          onError.toString());
    });
    return bytes;
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

  Future<void> requestBook() async {
    BaseOptions options = new BaseOptions(
      baseUrl: "http://mhyy.shuzhoukj.com",
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    Response response;
    Dio dio = new Dio(options);
    response = await dio.post("/Act/Apply",data: {"LoginOpenId": "o9W0Mt8obdv6rChRSPUmAOSO16dE", "Name": "桑享", "CellPhone": "15821758991","WxActId": "2009173210400023"});
    Toast.show(response.data.toString());
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