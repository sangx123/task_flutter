import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';

import 'load_image.dart';

/// 搜索页的AppBar
class SearchBarNew extends StatefulWidget implements PreferredSizeWidget {
  const SearchBarNew({
    Key key,
    this.hintText: "",
    this.backImg: "assets/images/ic_back_black.png",
    this.onPressed,
  }) : super(key: key);

  final String backImg;
  final String hintText;
  final VoidCallback onPressed;

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}

class _SearchBarState extends State<SearchBarNew> {
  SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle.light;
  TextEditingController _controller = TextEditingController();

  Color getColor() {
    return overlayStyle == SystemUiOverlayStyle.light
        ? Colours.dark_text
        : Colours.text;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    overlayStyle =
        isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
    Color iconColor = isDark ? Colours.dark_text_gray : Colours.text_gray_c;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Material(
        color: Colours.app_main,
        child: SafeArea(
          child: Container(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        Navigator.maybePop(context);
                      },
                      borderRadius: BorderRadius.circular(24.0),
                      child: Padding(
                        key: const Key('search_back'),
                        padding: const EdgeInsets.all(12.0),
//                      child: Image.asset(
//                        widget.backImg,
//                        color: getColor(),
//                      ),
                      ),
                    ),
                  ),
                  Expanded(

                    child:DecoratedBox(
                      decoration: BoxDecoration(
                          color: isDark ? Colours.dark_material_bg : Colours.bg_gray,
                          borderRadius: BorderRadius.circular(8.0),
//                          boxShadow: [
//                            BoxShadow(color: isDark ? Colours.dark_material_bg : Colours.bg_gray, offset: Offset(0.0, 2.0), blurRadius: 8.0, spreadRadius: 0.0),
//                          ]
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: 32.0,
                        decoration: BoxDecoration(
                          color: isDark ? Colours.dark_material_bg : Colours.bg_gray,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child:  InkWell(
                            onTap:widget.onPressed,
                            child:
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Gaps.hGap8,
                                LoadAssetImage("order/order_search", color: iconColor,width: 15,height: 15,),
                                Gaps.hGap8,
                                Text(widget.hintText)
                            ],)


//                            TextField(
//                              key: const Key('srarch_text_field'),
////                      autofocus: true,
//                              enableInteractiveSelection: false,
//                              onTap: () { FocusScope.of(context).requestFocus(new FocusNode()); },
//                              enabled: false,
//                              decoration: InputDecoration(
//                                contentPadding: const EdgeInsets.only(top: 0.0, left: -8.0, right: -16.0, bottom: 14.0),
//                                border: InputBorder.none,
//                                icon: Padding(
//                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
//                                  child: LoadAssetImage("order/order_search", color: iconColor,),
//                                ),
//                                hintText: widget.hintText,
//                              ),
//                            )
                        ),
                      ),
                    )
                  ),
                  Gaps.hGap50,
//                  Theme(
//                    data: Theme.of(context).copyWith(
//                      buttonTheme: ButtonThemeData(
//                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                          height: 32.0,
//                          minWidth: 44.0,
//                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 距顶部距离为0
//                          shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(4.0),
//                          )
//                      ),
//                    ),
//                    child: FlatButton(
//                      textColor: isDark ?  Colours.dark_button_text : Colors.white,
//                      color: isDark ?  Colours.dark_app_main : Colours.app_main,
//                      onPressed:(){
//                        FocusScope.of(context).unfocus();
//                        widget.onPressed(_controller.text);
//                      },
//                      child: Text("搜索", style: TextStyle(fontSize: Dimens.font_sp14)),
//                    ),
//                  ),
                  //Gaps.hGap16,
                ],
              )
          ),
        ),
      ),
    );
  }
}
