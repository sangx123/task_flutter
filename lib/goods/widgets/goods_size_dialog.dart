
import 'package:flutter/material.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/base_dialog.dart';

/// design/4商品/index.html#artboard10
class GoodsSizeDialog extends StatefulWidget{

  GoodsSizeDialog({
    Key key,
    this.onPressed,
  }) : super(key : key);

  final Function(String) onPressed;
  
  @override
  _GoodsSizeDialog createState() => _GoodsSizeDialog();
  
}

class _GoodsSizeDialog extends State<GoodsSizeDialog>{

  TextEditingController _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: "规格名称",
      child: Container(
        height: 34.0,
        margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        decoration: BoxDecoration(
          color: ThemeUtils.getDialogTextFieldColor(context),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: TextField(
          autofocus: true,
          controller: _controller,
          maxLines: 1,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0, bottom: 14.0),
            border: InputBorder.none,
            hintText: "输入文字…",
            //hintStyle: TextStyles.textGrayC14,
          ),
        ),
      ),
      onPressed: (){
        NavigatorUtils.goBack(context);
        widget.onPressed(_controller.text);
      },
    );
  }
}