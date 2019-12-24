
import 'package:flutter/material.dart';
import 'package:flutter_deer/account/models/withdrawal_account_model.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/number_text_input_formatter.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_button.dart';

import '../account_router.dart';

/// design/6店铺-账户/index.html#artboard3
class WithdrawalPage extends StatefulWidget {
  @override
  _WithdrawalPageState createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  
  TextEditingController _controller = TextEditingController();
  int _withdrawalType = 0;
  bool _isClick = false;
  WithdrawalAccountModel _data = WithdrawalAccountModel("尾号5236 李艺", "工商银行", 0, "123");
  
  @override
  void initState() {
    super.initState();
    _controller.addListener(_verify);
  }

  void _verify(){
    String price = _controller.text;
    if (price.isEmpty || double.parse(price) < 1) {
      setState(() {
        _isClick = false;
      });
      return;
    }
    setState(() {
      _isClick = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle = Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);

    return WillPopScope(
      onWillPop: (){
        /// 拦截返回，关闭键盘，否则会造成上一页面短暂的组件溢出
        FocusScope.of(context).unfocus();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: const MyAppBar(
          title: "提现",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Gaps.vGap5,
              InkWell(
                onTap: (){
                  NavigatorUtils.pushResult(context, AccountRouter.withdrawalAccountListPage, (result){
                    setState(() {
                      _data = result;
                    });
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  width: double.infinity,
                  height: 74.0,
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      LoadAssetImage(_data.type == 0 ? "account/yhk" : "account/wechat", width: 24.0),
                      Gaps.hGap16,
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(_data.typeName),
                            Gaps.vGap8,
                            Text(_data.name, style: Theme.of(context).textTheme.subtitle),
                          ],
                        ),
                      ),
                      Images.arrowRight
                    ],
                  ),
                ),
              ),
              Gaps.vGap16,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text("提现金额", style: TextStyles.textBold14),
                        Text("单笔2万，单日2万", style: const TextStyle(fontSize: Dimens.font_sp12, color: Color(0xFFFF8547)))
                      ],
                    ),
                    Gaps.vGap8,
                    Row(
                      children: <Widget>[
                        Container(
                          width: 15.0,
                          height: 40.0,
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: LoadAssetImage("account/rmb", color: ThemeUtils.getIconColor(context),)
                        ),
                        Gaps.hGap8,
                        Expanded(
                          child: TextField(
                            maxLength: 10,
                            controller: _controller,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [UsNumberTextInputFormatter()],
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 8.0),
                              hintStyle: TextStyle(
                                fontSize: Dimens.font_sp14,
                                fontWeight: FontWeight.normal,
                                color: Colours.text_gray_c
                              ),
                              hintText: "不能少于1元",
                              counterText: "",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gaps.line,
                    Gaps.vGap8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("最多可提现70元", style: Theme.of(context).textTheme.subtitle),
                        InkWell(
                          onTap: (){
                            _controller.text = "70";
                          },
                          child: Text("全部提现", style: TextStyle(
                            fontSize: Dimens.font_sp12,
                            color: Theme.of(context).primaryColor,
                          ))
                        )
                      ],
                    ),
                    Gaps.vGap16,
                    Gaps.vGap16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text("转出方式", style: TextStyles.textBold14),
                        const LoadAssetImage("account/sm", width: 16.0)
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          _withdrawalType = 0;
                        });
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 74.0,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 18.0,
                              left: 0.0,
                              child: LoadAssetImage(_withdrawalType == 0 ? "account/txxz" : "account/txwxz", width: 16.0)
                            ),
                            Positioned(
                              top: 16.0,
                              left: 24.0,
                              right: 0.0,
                              child: const Text("快速到账")
                            ),
                            Positioned(
                              bottom: 16.0,
                              left: 24.0,
                              right: 0.0,
                              child: RichText(
                                text: TextSpan(
                                  text: '手续费按',
                                  style: textTextStyle,
                                  children: <TextSpan>[
                                    TextSpan(text: '0.3%', style: const TextStyle(color: Color(0xFFFF8547))),
                                    TextSpan(text: '收取'),
                                  ],
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gaps.line,
                    InkWell(
                      onTap: (){
                        setState(() {
                          _withdrawalType = 1;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 74.0,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 18.0,
                              left: 0.0,
                              child: LoadAssetImage(_withdrawalType == 1 ? "account/txxz" : "account/txwxz", width: 16.0)
                            ),
                            Positioned(
                              top: 16.0,
                              left: 24.0,
                              right: 0.0,
                              child: const Text("普通到账")
                            ),
                            Positioned(
                              bottom: 16.0,
                              left: 24.0,
                              right: 0.0,
                              child: RichText(
                                text: TextSpan(
                                  text: '预计',
                                  style: textTextStyle,
                                  children: <TextSpan>[
                                    TextSpan(text: 'T+1天到账(免手续费，T为工作日)', style: const TextStyle(color: Color(0xFFFF8547))),
                                   ],
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gaps.vGap16,
                    Gaps.vGap8,
                    MyButton(
                      key: const Key('提现'),
                      onPressed: _isClick ? (){
                        NavigatorUtils.push(context, AccountRouter.withdrawalResultPage);
                      } : null,
                      text: "提现",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),  
      ),
    );
  }
}
