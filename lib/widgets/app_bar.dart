
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';

/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget{

  const MyAppBar({
    Key key,
    this.backgroundColor,
    this.title: "",
    this.centerTitle: "",
    this.actionName: "",
    this.backImg: "assets/images/ic_back_black.png",
    this.onPressed,
    this.isBack: true,
    this.hasLine:true
  }): super(key: key);

  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;
  final bool hasLine;
  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;

    if (backgroundColor == null){
      _backgroundColor = ThemeUtils.getBackgroundColor(context);
    }else{
      _backgroundColor = backgroundColor;
    }

    SystemUiOverlayStyle _overlayStyle = ThemeData.estimateBrightnessForColor(_backgroundColor) == Brightness.dark
        ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Stack(
            //将子控件以右中心对齐

            //alignment: Alignment.centerLeft,
            children: <Widget>[
              Align(
                child: Column(
                  //将子控件放在主轴的中间位置
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
                      width: double.infinity,
                      child: Text(
                          title.isEmpty ? centerTitle : title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold ,
                            fontSize: 16.5,
                            color: _overlayStyle == SystemUiOverlayStyle.light ?  Colours.dark_text : Colours.text,
                          )
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    ),
                  ],
                ),
                alignment: AlignmentDirectional.centerStart,
              ),
              Align(
                child: isBack ? IconButton(

                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    Navigator.maybePop(context);
                  },
                  tooltip: 'Back',
                  padding: const EdgeInsets.all(12.0),
                  icon: Icon(Icons.arrow_back),
//                Image.asset(
//                  backImg,
//                  color: _overlayStyle == SystemUiOverlayStyle.light ? Colours.dark_text : Colours.text,
//                ),
                ) : Gaps.empty,
                alignment: AlignmentDirectional.centerStart,
              ),
              Positioned(
                right: 0.0,
                child: Theme(
                  data: Theme.of(context).copyWith(
                      buttonTheme: ButtonThemeData(
                        //padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        //minWidth: 60.0,
                      )
                  ),
                  child: actionName.isEmpty ? Container() :
                  //圆角按钮
                  FlatButton(
                      child: Container(
                      decoration: BoxDecoration(
                      // 设置圆角
                      borderRadius: BorderRadius.circular(6),
                        // 设置渐变色
                        gradient: LinearGradient(colors: <Color>[
                          Colours.app_main,Colours.app_main
                        ])
                    ),
                    child: Text(actionName, style: TextStyle( color: Colours.material_bg),),
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
                  ),

                    //Text(actionName, key: const Key('actionName')),
                    textColor: _overlayStyle == SystemUiOverlayStyle.light ? Colours.dark_text : Colours.text,
                    //highlightColor: Colors.transparent,
                    onPressed: onPressed,
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0,
                right: 0,
                child: hasLine? Container(width: double.infinity, height: 1.0, color: Color(0xFFF3F3F3),):Container()
//                child: Container(
//                  color: Colors.blue,
//                  width:  double.infinity,
//                  child: Text("第一个组件"),
//                ),
                //child:  Container(height: 0.6, width: double.infinity, margin: const EdgeInsets.only(left: 16.0), child: Gaps.line),
                )
          ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}
