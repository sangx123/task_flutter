
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_amap/flutter_2d_amap.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/shop_router.dart';
import 'package:flutter_deer/store/store_router.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/selected_image.dart';
import 'package:flutter_deer/widgets/store_select_text_item.dart';
import 'package:flutter_deer/widgets/text_field_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:keyboard_actions/keyboard_actions.dart';


/// design/2店铺审核/index.html
class StoreAuditPage extends StatefulWidget {
  @override
  _StoreAuditPageState createState() => _StoreAuditPageState();
}

class _StoreAuditPageState extends State<StoreAuditPage> {

  File _imageFile;
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();

  String _address = "陕西省 西安市 雁塔区 高新六路201号";
  
  void _getImage() async{
    try {
      _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 800, imageQuality: 95);
      setState(() {});
    } catch (e) {
      Toast.show("没有权限，无法打开相册！");
    }
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _nodeText1,
          displayCloseWidget: false,
        ),
        KeyboardAction(
          focusNode: _nodeText2,
          displayCloseWidget: false,
        ),
        KeyboardAction(
          focusNode: _nodeText3,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: const Text("关闭"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: const MyAppBar(
        centerTitle: "修改个人资料",
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: defaultTargetPlatform == TargetPlatform.iOS ? FormKeyboardActions(
                child: _buildBody()
              ) : SingleChildScrollView(
                child: _buildBody()
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: MyButton(
                onPressed: (){
                  //这个地方是save图片
                  //NavigatorUtils.push(context, StoreRouter.auditResultPage);
                },
                text: "提交",
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildBody(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gaps.vGap5,
          const Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text("个人资料", style: TextStyles.textBold18),
          ),
          Gaps.vGap16,
          Center(
            child: SelectedImage(
              image: _imageFile,
              onTap: _getImage
            ),
          ),
          Gaps.vGap10,
////          Center(
////            child: Text(
////              "我的图像",
////              style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: Dimens.font_sp14),
////            ),
////          ),
//          Gaps.vGap16,
          TextFieldItem(
              focusNode: _nodeText1,
              title: "昵称",
              hintText: "填写店铺名称"
          ),
          StoreSelectTextItem(
              title: "主营范围",
              content: _sortName,
              onTap: () => _showBottomSheet()
          ),
          StoreSelectTextItem(
              title: "店铺地址",
              content: _address,
              onTap: (){
                NavigatorUtils.pushResult(context, ShopRouter.addressSelectPage, (result){
                  setState(() {
                    PoiSearch model = result;
                    _address = model.provinceName + " " +
                        model.cityName + " " +
                        model.adName + " " +
                        model.title;
                  });
                });
              }
          ),
          Gaps.vGap16,
          Gaps.vGap16,
          const Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text("店主信息", style: TextStyles.textBold18),
          ),
          Gaps.vGap16,
          TextFieldItem(
              focusNode: _nodeText2,
              title: "店主姓名",
              hintText: "填写店主姓名"
          ),
          TextFieldItem(
              focusNode: _nodeText3,
              config: _buildConfig(context),
              keyboardType: TextInputType.phone,
              title: "联系电话",
              hintText: "填写店主联系电话"
          )
        ],
      ),
    );
  }

  String _sortName = "";
  var _list = ["水果生鲜", "家用电器", "休闲食品", "茶酒饮料", "美妆个护", "粮油调味", "家庭清洁", "厨具用品", "儿童玩具", "床上用品"];

  _showBottomSheet(){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 360.0,
          child: ListView.builder(
            key: const Key('goods_sort'),
            itemExtent: 48.0,
            itemBuilder: (_, index){
              return InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(_list[index]),
                ),
                onTap: (){
                  setState(() {
                    _sortName = _list[index];
                  });
                  NavigatorUtils.goBack(context);
                },
              );
            },
            itemCount: _list.length,
          ),
        );
      },
    );
  }
}
