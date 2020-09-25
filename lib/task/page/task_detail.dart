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

  const TaskDetailPage({Key key, this.content}) : super(key: key);

  final String content;
  @override
  _TaskDetailPage createState() => _TaskDetailPage();
}

class _TaskDetailPage extends State<TaskDetailPage> {
  ZefyrController _controller =
  ZefyrController(NotusDocument());

  FocusNode _focusNode = FocusNode();

  bool _editing = false;
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
    bool isDark = ThemeUtils.isDark(context);

    Color red = Theme
        .of(context)
        .errorColor;
    Color blue = Theme
        .of(context)
        .primaryColor;

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
        appBar: MyAppBar(
                centerTitle: "任务详情",
                actionName: "",
                onPressed:()=>{},
            ),
        body: Stack(
          children: <Widget>[
          ZefyrScaffold(
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
          Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Material(
                    color: ThemeUtils.getBackgroundColor(context),
                    child: SafeArea(
                    child: Container(
                    height: 60.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Theme(
                    data: Theme.of(context).copyWith(
                    buttonTheme: ButtonThemeData(
                    height: 44.0,
                    )
                    ),
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
                    textColor: isDark ? Colours.dark_button_text : Colors.white,
                    child: const Text(
                    "申请任务",
                    style: TextStyle(
                    fontSize: Dimens.font_sp18
                    ),
                    ),
                    onPressed: (){},
                    ),
                    )
                    ],
                    ),
                    ),
                    ),
                    ),
                    ),
                    )
          ],
          ),
        );
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