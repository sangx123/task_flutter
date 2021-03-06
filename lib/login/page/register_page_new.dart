import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/net/dio_utils.dart';
import 'package:flutter_deer/net/http_api.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/models/user_entity.dart';
import 'package:flutter_deer/store/store_router.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/text_field.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:flustars/flustars.dart' as FlutterStars;
import 'package:mobsms/mobsms.dart';

/// design/1注册登录/index.html#artboard11
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //定义一个controller
  TextEditingController _nameController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nickNameController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  final FocusNode _nodeText4 = FocusNode();
  bool _isClick = false;

  @override
  void initState() {
    super.initState();
    //监听输入改变
    _nameController.addListener(_verify);
    _vCodeController.addListener(_verify);
    _passwordController.addListener(_verify);
    _nickNameController.addListener(_verify);
  }

  void _verify() {
    String name = _nameController.text;
    String vCode = _vCodeController.text;
    String password = _passwordController.text;
    String nickName = _nickNameController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 11) {
      isClick = false;
    }
    if (vCode.isEmpty || vCode.length < 4) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }
    if (nickName.trim().isEmpty) {
      isClick = false;
    }
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  void _submit() {
    Smssdk.commitCode(_nameController.text, "86", _vCodeController.text,
        (dynamic ret, Map err) {
      if (err != null) {
        Toast.show("用户输入的验证码错误！");
      } else {
        _register();
      }
    });
  }

  Future<void> _register() async {
    await DioUtils.instance.requestNetwork<UserEntity>(
      Method.post,
      HttpApi.register,
      onSuccess: (data) {
        Toast.show("注册成功");
        FlutterStars.SpUtil.putString(Constant.phone, _nameController.text);
        //NavigatorUtils.push(context, StoreRouter.auditPage);
      },
      onError: (code, msg) {
        Toast.show(msg);
      },
      params: {
        "name": _nameController.text,
        "mobile": _nameController.text,
        "password": FlutterStars.EncryptUtil.encodeMd5(_passwordController.text)
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: "",
          hasLine: false,
        ),
        body: defaultTargetPlatform == TargetPlatform.iOS
            ? FormKeyboardActions(
                child: _buildBody(),
              )
            : SingleChildScrollView(
                child: _buildBody(),
              ));
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            "手机号注册",
            style: TextStyles.textBold24,
          ),
          Gaps.vGap16,
//          Row(
//            children: [
//
//          ],),
          //在这里也套了个Expanded
          Row(
            children: <Widget>[
              //在这里套了个Expanded
              Text(
                "昵称    ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Gaps.hGap16,
              Expanded(
                child: TextField(
                  focusNode: _nodeText4,
                  controller: _nickNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    hintText: "例如: 心享",
                    counterText: "",
                    border: InputBorder.none,
                  ),
                  maxLength: 20,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Color(0xFFF3F3F3),
          ),
          //Container(width: double.infinity, height: 1.0, color: Color(0xFFF3F3F3),),
          Gaps.vGap16,
          Row(
            children: <Widget>[
              //在这里套了个Expanded
              Text(
                "手机号",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Gaps.hGap16,
              Expanded(
                child: TextField(
                  focusNode: _nodeText1,
                  controller: _nameController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    hintText: "请输入手机号",
                    counterText: "",
                    border: InputBorder.none,
                  ),
                  maxLength: 11,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Color(0xFFF3F3F3),
          ),
          Gaps.vGap8,
          Row(
            children: <Widget>[
              //在这里套了个Expanded
              Text(
                "验证码",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Gaps.hGap16,
              Expanded(
                child: TextField(
                  focusNode: _nodeText2,
                  controller: _vCodeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    hintText: "请输入验证码",
                    counterText: "",
                    border: InputBorder.none,
                  ),
                  maxLength: 6,
                ),
              ),
              FlatButton(
                child: Container(
                  decoration: BoxDecoration(
                      // 设置圆角
                      borderRadius: BorderRadius.circular(6),
                      // 设置渐变色
                      gradient: LinearGradient(
                          colors: <Color>[Colours.app_main, Colours.app_main])),
                  child: Text(
                    "获取验证码",
                    style: TextStyle(color: Colours.material_bg),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
                ),

                //Text(actionName, key: const Key('actionName')),
                //textColor: _overlayStyle == SystemUiOverlayStyle.light ? Colours.dark_text : Colours.text,
                //highlightColor: Colors.transparent,
                //onPressed: onPressed,
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Color(0xFFF3F3F3),
          ),
//          MyTextField(
//            key: const Key('vcode'),
//            focusNode: _nodeText2,
//            controller: _vCodeController,
//            keyboardType: TextInputType.number,
//            getVCode: () async {
//              if (_nameController.text.length == 11) {
//                //Toast.show("并没有真正发送哦，直接登录吧！");
//                /// 一般可以在这里发送真正的请求，请求成功返回true
//                Smssdk.getTextCode(_nameController.text, "86", "",
//                    (dynamic ret, Map err) {
//                  if (err != null) {
//                    Toast.show(err.toString());
//                  }
//                });
//                return true;
//              } else {
//                Toast.show("请输入有效的手机号");
//                return false;
//              }
//            },
//            maxLength: 6,
//            hintText: "请输入验证码",
//          ),
          Gaps.vGap8,

          Row(
            children: <Widget>[
              //在这里套了个Expanded
              Text(
                "密码    ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Gaps.hGap16,
              Expanded(
                child: TextField(
                  focusNode: _nodeText3,
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    hintText: "请输入6位及以上的密码",
                    counterText: "",
                    border: InputBorder.none,
                  ),
                  maxLength: 16,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Color(0xFFF3F3F3),
          ),
//          MyTextField(
//            key: const Key('password'),
//            keyName: 'password',
//            focusNode: _nodeText3,
//            isInputPwd: true,
//            controller: _passwordController,
//            keyboardType: TextInputType.visiblePassword,
//            maxLength: 16,
//            hintText: "请输入密码",
//          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            key: const Key('register'),
            onPressed: _isClick ? _submit : null,
            text: "注册",
          )
        ],
      ),
    );
  }
}
