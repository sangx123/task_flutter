import 'package:flutter/material.dart';
import 'package:flutter_deer/account/account_router.dart';
import 'package:flutter_deer/account/models/bank_model.dart';
import 'package:flutter_deer/account/models/city_model.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/store_select_text_item.dart';
import 'package:flutter_deer/widgets/text_field_item.dart';


/// design/6店铺-账户/index.html#artboard29
class AddWithdrawalAccountPage extends StatefulWidget {
  @override
  _AddWithdrawalAccountPageState createState() => _AddWithdrawalAccountPageState();
}

class _AddWithdrawalAccountPageState extends State<AddWithdrawalAccountPage> {
  bool _isWechat = false;
  String _accountType = "银行卡(对私账户)";
  String _city = "";
  String _bank = "";
  String _bank1 = "";
  
  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.subtitle.copyWith(fontSize: Dimens.font_sp14);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(
        title: "添加账号",
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Gaps.vGap5,
                    StoreSelectTextItem(
                      title: "账号类型",
                      content: _accountType,
                      onTap: () => _showSelectAccountTypeDialog(),
                    ),
                    Offstage(
                      offstage: _isWechat,
                      child: Column(
                        children: <Widget>[
                          TextFieldItem(
                            title: "持  卡  人",
                            hintText: "填写您的真实姓名",
                          ),
                          TextFieldItem(
                            title: "银行卡号",
                            keyboardType: TextInputType.number,
                            hintText: "填写银行卡号",
                          ),
                          StoreSelectTextItem(
                            title: "开  户  地",
                            content: _city.isEmpty ? "选择开户城市" : _city,
                            style: _city.isEmpty ? style: null,
                            onTap: () {
                              NavigatorUtils.pushResult(context, AccountRouter.citySelectPage, (result){
                                setState(() {
                                  CityModel model = result;
                                  _city = model.name;
                                });
                              });
                            },
                          ),
                          StoreSelectTextItem(
                            title: "银行名称",
                            content: _bank.isEmpty ? "选择开户银行" : _bank,
                            style: _bank.isEmpty ? style : null,
                            onTap: () {
                              NavigatorUtils.pushResult(context, '${AccountRouter.bankSelectPage}?type=0', (result){
                                setState(() {
                                  BankModel model = result;
                                  _bank = model.bankName;
                                });
                              });
                            },
                          ),
                          StoreSelectTextItem(
                            title: "支行名称",
                            content: _bank1.isEmpty ? "选择开户支行" : _bank1,
                            style: _bank1.isEmpty ? style : null,
                            onTap: () {
                              NavigatorUtils.pushResult(context, '${AccountRouter.bankSelectPage}?type=1', (result){
                                setState(() {
                                  BankModel model = result;
                                  _bank1 = model.bankName;
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Text(_isWechat ? "绑定本机当前登录的微信号" : "绑定持卡人本人的银行卡",
                          style: Theme.of(context).textTheme.subtitle),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: MyButton(
                onPressed: () => NavigatorUtils.goBack(context),
                text: "确定",
              ),
            )
          ],
        ),
      ),
    );
  }

  _dialogSelect(bool flag) {
    setState(() {
      _isWechat = flag;
    });
    NavigatorUtils.goBack(context);
  }

  /// design/6店铺-账户/index.html#artboard30
  _showSelectAccountTypeDialog() {
    showElasticDialog(
        context: context,
        builder: (BuildContext context) {
          Color textColor = Theme.of(context).primaryColor;
          return Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: ThemeUtils.getDialogBackgroundColor(context),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                width: 270.0,
                height: 190.0,
                padding: const EdgeInsets.only(top: 24.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    buttonTheme: ButtonThemeData(
                      minWidth: double.infinity,
                    ),
                    textTheme: TextTheme(
                        button: TextStyle(
                      fontSize: Dimens.font_sp14,
                    )),
                  ),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "账号类型",
                        style: TextStyles.textBold18,
                      ),
                      Gaps.vGap16,
                      Gaps.line,
                      Expanded(
                        child: FlatButton(
                          child: Text("微信"),
                          textColor: textColor,
                          onPressed: () {
                            _accountType = "微信";
                            _dialogSelect(true);
                          },
                        ),
                      ),
                      Gaps.line,
                      Expanded(
                        child: FlatButton(
                          child: Text("银行卡(对私账户)"),
                          textColor: textColor,
                          onPressed: () {
                            _accountType = "银行卡(对私账户)";
                            _dialogSelect(false);
                          },
                        ),
                      ),
                      Gaps.line,
                      Expanded(
                        child: FlatButton(
                          child: Text("银行卡(对公账户)"),
                          textColor: textColor,
                          onPressed: () {
                            _accountType = "银行卡(对公账户)";
                            _dialogSelect(false);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
