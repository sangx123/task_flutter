
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flustars/flustars.dart' as FlutterStars;
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
import 'package:keyboard_actions/keyboard_actions.dart';

import '../login_router.dart';

/// design/1注册登录/index.html
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //定义一个controller
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _isClick = false;

  @override
  void initState() {
    super.initState();
    //监听输入改变  
    _nameController.addListener(_verify);
    _passwordController.addListener(_verify);
    _nameController.text = FlutterStars.SpUtil.getString(Constant.phone);
    _passwordController.text=FlutterStars.SpUtil.getString(Constant.password);
  }

  void _verify(){
    String name = _nameController.text;
    String password = _passwordController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 11) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isClick != _isClick){
      setState(() {
        _isClick = isClick;
      });
    }
  }
  
  Future<void> _login() async {
    //NavigatorUtils.push(context, StoreRouter.auditPage);
    await DioUtils.instance.requestNetwork<UserEntity>(
        Method.post, HttpApi.login,
        onSuccess: (data){
          FlutterStars.SpUtil.putString(Constant.phone, _nameController.text);
          FlutterStars.SpUtil.putString(Constant.password, _passwordController.text);
          FlutterStars.SpUtil.putBool(Constant.isLogin, true);
          NavigatorUtils.push(context, StoreRouter.auditPage);
        },
        onError: (code,msg){
            Toast.show(msg);
        },
        params: {"mobile": _nameController.text,"password":FlutterStars.EnDecodeUtil.encodeMd5(_passwordController.text)},
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: false,
        actionName: '验证码登录',
        onPressed: (){
          NavigatorUtils.push(context, LoginRouter.smsLoginPage);
        },
      ),
      body: defaultTargetPlatform == TargetPlatform.iOS ? FormKeyboardActions(
        child: _buildBody(),
      ) : SingleChildScrollView(
        child: _buildBody(),
      ) 
    );
  }
  
  _buildBody(){
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "密码登录",
            style: TextStyles.textBold26,
          ),
          Gaps.vGap16,
          MyTextField(
            key: const Key('phone'),
            focusNode: _nodeText1,
            controller: _nameController,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            hintText: "请输入账号",
          ),
          Gaps.vGap8,
          MyTextField(
            key: const Key('password'),
            keyName: 'password',
            focusNode: _nodeText2,
            config: Utils.getKeyboardActionsConfig(context, [_nodeText1, _nodeText2]),
            isInputPwd: true,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            maxLength: 16,
            hintText: "请输入密码",
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            key: const Key('login'),
            onPressed: _isClick ? _login : null,
            text: "登录",
          ),
          Container(
            height: 40.0,
            alignment: Alignment.centerRight,
            //color: Colours.app_main,
            child: GestureDetector(
              child: Text(
                '忘记密码',
                style: Theme.of(context).textTheme.subtitle,
              ),
              onTap: () => NavigatorUtils.push(context, LoginRouter.resetPasswordPage),
            ),
          ),
          Gaps.vGap16,
          Container(
              alignment: Alignment.center,
              child: GestureDetector(
                child: Text(
                  '还没账号？快去注册',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor
                  ),
                ),
                onTap: () => NavigatorUtils.push(context, LoginRouter.registerPage),
              )
          )
        ],
      ),
    );
  }
}
