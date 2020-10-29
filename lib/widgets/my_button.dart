
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';

class MyButton extends StatelessWidget {

  const MyButton({
    Key key,
    this.text: "",
    @required this.onPressed,
  }): super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    return FlatButton(
      onPressed: onPressed,
      textColor: isDark ? Colours.dark_button_text : Colors.white,
      color: isDark ? Colours.dark_app_main : Colours.app_main,
      disabledTextColor: isDark ? Colours.dark_text_disabled : Colours.text_disabled,
      disabledColor: isDark ? Colours.dark_button_disabled : Colours.button_disabled,
//      decoration: BoxDecoration(
//        // 设置圆角
//          borderRadius: BorderRadius.circular(6),
//          // 设置渐变色
//          gradient: LinearGradient(colors: <Color>[
//            Colours.app_main,Colours.app_main
//          ])
//      ),
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      child: Column(
        children: <Widget>[
          Container(
            height: 48,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(text, style: TextStyle(fontSize: Dimens.font_sp18),),
          ),
        ],
      ),
    );
  }
}
