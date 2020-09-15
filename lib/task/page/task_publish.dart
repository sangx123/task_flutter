import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/net/net.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/zefyr_images.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';
/**
 * 发布任务的界面
 */
class PublishTaskPage extends StatefulWidget {
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
    _loadDocument().then((document) {
      setState(() {
        _controller = ZefyrController(document);
      });
    });
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
    final theme = ZefyrThemeData(
      cursorColor: Colors.blue,
      toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
        color: Colors.grey.shade800,
        toggleColor: Colors.grey.shade900,
        iconColor: Colors.white,
        disabledIconColor: Colors.grey.shade500,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar:  MyAppBar(
        centerTitle: "发布任务",
        actionName: "发布",
        onPressed:()=> _saveDocument(context),
      ),
      body: ZefyrScaffold(
        child: ZefyrTheme(
          data: theme,
          child: ZefyrEditor(
            controller: _controller,
            focusNode: _focusNode,
            mode: _editing ? ZefyrMode.edit : ZefyrMode.select,
            imageDelegate: CustomImageDelegate(),
          ),
        ),
      ),
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


  /// Loads the document asynchronously from a file if it exists, otherwise
  /// returns default document.
  Future<NotusDocument> _loadDocument() async {
    final file = File(Directory.systemTemp.path + "/quick_start.json");
    if (await file.exists()) {
      final contents = await file
          .readAsString()
          .then((data) => Future.delayed(Duration(seconds: 1), () => data));
      return NotusDocument.fromJson(jsonDecode(contents));
    }
    final Delta delta = Delta();
    return NotusDocument.fromDelta(delta);
//    final doc =
//        r'[{"insert":"Zefyr"},{"insert":"\n","attributes":{"heading":1}},{"insert":"Soft and gentle rich text editing for Flutter applications.","attributes":{"i":true}},{"insert":"\n"},{"insert":"​","attributes":{"embed":{"type":"image","source":"http://192.168.0.127/static/logo.png"}}},{"insert":"\n"},{"insert":"Photo by Hiroyuki Takeda.","attributes":{"i":true}},{"insert":"\nZefyr is currently in "},{"insert":"early preview","attributes":{"b":true}},{"insert":". If you have a feature request or found a bug, please file it at the "},{"insert":"issue tracker","attributes":{"a":"https://github.com/memspace/zefyr/issues"}},{"insert":'
//        r'".\nDocumentation"},{"insert":"\n","attributes":{"heading":3}},{"insert":"Quick Start","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/quick_start.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Data Format and Document Model","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/data_and_document.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Style Attributes","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/attr'
//        r'ibutes.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Heuristic Rules","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/heuristics.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"FAQ","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/faq.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Clean and modern look"},{"insert":"\n","attributes":{"heading":2}},{"insert":"Zefyr’s rich text editor is built with simplicity and fle'
//        r'xibility in mind. It provides clean interface for distraction-free editing. Think Medium.com-like experience.\nMarkdown inspired semantics"},{"insert":"\n","attributes":{"heading":2}},{"insert":"Ever needed to have a heading line inside of a quote block, like this:\nI’m a Markdown heading"},{"insert":"\n","attributes":{"block":"quote","heading":3}},{"insert":"And I’m a regular paragraph"},{"insert":"\n","attributes":{"block":"quote"}},{"insert":"Code blocks"},{"insert":"\n","attributes":{"headin'
//        r'g":2}},{"insert":"Of course:\nimport ‘package:flutter/material.dart’;"},{"insert":"\n","attributes":{"block":"code"}},{"insert":"import ‘package:zefyr/zefyr.dart’;"},{"insert":"\n\n","attributes":{"block":"code"}},{"insert":"void main() {"},{"insert":"\n","attributes":{"block":"code"}},{"insert":" runApp(MyZefyrApp());"},{"insert":"\n","attributes":{"block":"code"}},{"insert":"}"},{"insert":"\n","attributes":{"block":"code"}},{"insert":"\n\n\n"}]';
//
//
//    Delta detail= Delta.fromJson(json.decode(doc) as List);
//    return NotusDocument.fromDelta(detail);
  }

  void _saveDocument(BuildContext context) async{
    List<Future<MultipartFile>> imageList = new List<Future<MultipartFile>>();

    _editing = false;
    final contents = jsonEncode(_controller.document);

    Delta list= Delta.fromJson(json.decode(contents) as List);

    for(var item in list.toList()){
        if(item.attributes!=null&&item.attributes.containsKey("embed")){
          if(item.attributes["embed"]["type"]=="image"){
            var path= item.attributes["embed"]["source"];
            var name=path.toString().substring(path.toString().lastIndexOf("/")+1);
            print(path);
            print(name);
            //MultipartFile multipartFile =  await MultipartFile.fromFile(path, filename:name);
          }
        }
    }
    _createTask(contents);
    print(Directory.systemTemp.path);
    // For this example we save our document to a temporary file.
    final file = File(Directory.systemTemp.path + "/quick_start.json");
    // And show a snack bar on success.
    file.writeAsString(contents).then((_) {
      //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saved.")));
    });
    setState(() {
      //刷新界面
    });
  }

  Future<void> _createTask(String contents) async {
    //NavigatorUtils.push(context, StoreRouter.auditPage);
    await DioUtils.instance.requestNetwork<String>(
      Method.post, HttpApi.createTask,
      onSuccess: (data){
//        FlutterStars.SpUtil.putString(Constant.phone, _nameController.text);
//        FlutterStars.SpUtil.putString(Constant.password, _passwordController.text);
//        FlutterStars.SpUtil.putBool(Constant.isLogin, true);
//        FlutterStars.SpUtil.putString(Constant.accessToken, data.userToken);
//        NavigatorUtils.push(context, StoreRouter.auditPage);
      },
      onError: (code,msg){
        Toast.show(msg);
      },
      params: {"content": contents},
    );
  }
}