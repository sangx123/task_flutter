
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/widgets/goods_sort_dialog.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/click_item.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/selected_image.dart';
import 'package:flutter_deer/widgets/text_field_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/app_bar.dart';

import '../goods_router.dart';

/// design/4商品/index.html#artboard5
class GoodsEditPage extends StatefulWidget {
  
  const GoodsEditPage({Key key, this.isAdd: true, this.isScan}) : super(key: key);
  
  final bool isAdd;
  final bool isScan;
  
  @override
  _GoodsEditPageState createState() => _GoodsEditPageState();
}

class _GoodsEditPageState extends State<GoodsEditPage> {

  File _imageFile;
  String _goodsSortName;
  final TextEditingController _codeController = TextEditingController();
  
  void _getImage() async{
    try {
      _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 800);
      setState(() {});
    } catch (e) {
      Toast.show("没有权限，无法打开相册！");
    }
  }
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      if (widget.isScan){
        _scan();
      }
    });
  }
  
  void _scan() async {
    String code = await Utils.scan();
    if (code != null){
      _codeController.text = code;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: widget.isAdd ? "添加商品" : "编辑商品",
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                key: const Key('goods_edit_page'),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Gaps.vGap5,
                    const Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: const Text(
                        "基本信息",
                        style: TextStyles.textBold18,
                      ),
                    ),
                    Gaps.vGap16,
                    Center(
                      child: SelectedImage(
                        size: 96.0,
                        image: _imageFile,
                        onTap: _getImage
                      ),
                    ),
                    Gaps.vGap8,
                    Center(
                      child: Text(
                        "点击添加商品图片",
                        style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: Dimens.font_sp14),
                      ),
                    ),
                    Gaps.vGap16,
                    TextFieldItem(
                      title: "商品名称",
                      hintText: "填写商品名称",
                    ),
                    TextFieldItem(
                      title: "商品简介",
                      hintText: "填写简短描述",
                    ),
                    TextFieldItem(
                      title: "折后价格",
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      hintText: "填写商品单品折后价格",
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        TextFieldItem(
                          controller: _codeController,
                          title: "商品条码",
                          hintText: "选填",
                        ),
                        Positioned(
                          right: 16.0,
                          child: GestureDetector(
                            child: ThemeUtils.isDark(context) ? 
                            const LoadAssetImage("goods/icon_sm", width: 16.0, height: 16.0) : 
                            const LoadAssetImage("goods/scanning", width: 16.0, height: 16.0),
                            onTap: _scan,
                          ),
                        )
                      ],
                    ),
                    TextFieldItem(
                      title: "商品说明",
                      hintText: "选填",
                    ),
                    Gaps.vGap16,
                    Gaps.vGap16,
                    const Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: const Text(
                        "折扣立减",
                        style: TextStyles.textBold18,
                      ),
                    ),
                    Gaps.vGap16,
                    TextFieldItem(
                      title: "立减金额",
                      keyboardType: TextInputType.numberWithOptions(decimal: true)
                    ),
                    TextFieldItem(
                      title: "折扣金额",
                      keyboardType: TextInputType.numberWithOptions(decimal: true)
                    ),
                    Gaps.vGap16,
                    Gaps.vGap16,
                    const Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: const Text(
                        "类型规格",
                        style: TextStyles.textBold18,
                      ),
                    ),
                    Gaps.vGap16,
                    ClickItem(
                      title: "商品类型",
                      content: _goodsSortName ?? "选择商品类型",
                      onTap: () => _showBottomSheet(),
                    ),
                    ClickItem(
                      title: "商品规格",
                      content: "对规格进行编辑",
                      onTap: () => NavigatorUtils.push(context, GoodsRouter.goodsSizePage),
                    ),
                    Gaps.vGap8,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: MyButton(
                onPressed: (){
                  NavigatorUtils.goBack(context);
                },
                text: "提交",
              ),
            )
          ],
        ),
      ),
    );
  }

  _showBottomSheet(){
    showModalBottomSheet(
      context: context,
      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      builder: (BuildContext context) {
        return GoodsSortDialog(
          onSelected: (_, name){
            setState(() {
              _goodsSortName = name;
            });
          },
        );
      },
    );
  }
}
