import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:zefyr/zefyr.dart';
class ListBodyPage extends StatefulWidget{
  @override
  _ListBodyPageState createState() {

    return _ListBodyPageState();
  }
}

class _ListBodyPageState extends State<ListBodyPage>{
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Widget body = ListBody(children: <Widget>[
      TextField(decoration: InputDecoration(
          hintText:  "在这里开始..."
      ),),
      TextField(decoration: InputDecoration(
          hintText:  "在这里开始..."
      ),),
      TextField(decoration: InputDecoration(
          hintText:  "在这里开始..."
      ),),
      TextField(decoration: InputDecoration(
          hintText:  "在这里开始..."
      ),), TextField(decoration: InputDecoration(
          hintText:  "在这里开始..."
      ),),
      TextField(decoration: InputDecoration(
          hintText:  "在这里开始..."
      ),),
      TextField(decoration: InputDecoration(
          hintText:  "在这里开始..."
      ),),
      TextField(decoration: InputDecoration(
          hintText:  "在这里开始..."
      ),),
      TextField(decoration: InputDecoration(
          hintText:  "在这里开始..."
      ),),
      TextField(decoration: InputDecoration(
          hintText:  "在这里开始..."
      ),),
      TextField(decoration: InputDecoration(
          hintText:  "在这里开始..."
      ),),
      TextField(decoration: InputDecoration(
          hintText:  "在这里开始..."
      ),),
      TextField(decoration: InputDecoration(
          hintText:  "在这里开始..."
      ),),

    ],);

    body = SingleChildScrollView(
      controller: _scrollController,
      child: body,
    );

    final layers = <Widget>[body];
    layers.add(body);

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: const MyAppBar(
        centerTitle: "测试",
      ),
      body: Stack(fit: StackFit.expand, children: layers),
    );
  }

  TextSelectionControls defaultSelectionControls(BuildContext context) {
    TargetPlatform platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS) {
      return cupertinoTextSelectionControls;
    }
    return materialTextSelectionControls;
  }


}