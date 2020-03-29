import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/util/zefyr_images.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:zefyr/zefyr.dart';

class PublishTaskPage extends StatefulWidget {
  @override
  _PublishTaskState createState() => _PublishTaskState();
}

class _PublishTaskState extends State<PublishTaskPage> {
  final ZefyrController _controller =
  ZefyrController(NotusDocument());
  final FocusNode _focusNode = FocusNode();

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

    final done = _editing
        ? [FlatButton(onPressed: _stopEditing, child: Text('DONE'))]
        : [FlatButton(onPressed: _startEditing, child: Text('EDIT'))];
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: const MyAppBar(
        centerTitle: "发布任务",
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
}