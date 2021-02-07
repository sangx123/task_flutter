import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart' hide MyAppBar;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_amap/flutter_2d_amap.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_deer/common/KeyValueItem.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/goods/goods_router.dart';
import 'package:flutter_deer/goods/widgets/goods_sort_dialog.dart';
import 'package:flutter_deer/net/net.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/res/dimens.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/res/styles.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/shop_router.dart';
import 'package:flutter_deer/store/store_router.dart';
import 'package:flutter_deer/task/models/task_main_type_model_entity.dart';
import 'package:flutter_deer/task/task_router.dart';
import 'package:flutter_deer/util/file_utils.dart';
import 'package:flutter_deer/util/log_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/throttle_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/util/zefyr_images.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/click_item.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/selected_image.dart';
import 'package:flutter_deer/widgets/store_select_text_item.dart';
import 'package:flutter_deer/widgets/text_field.dart';
import 'package:flutter_deer/widgets/text_field_item.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tobias/tobias.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';

/**
 * 发布任务的界面
 */
class PublishTaskEndPage extends StatefulWidget {
  bool isAdd = true;
  bool isScan = false;

  @override
  _PublishTaskEndState createState() => _PublishTaskEndState();
}

class _PublishTaskEndState extends State<PublishTaskEndPage> {
  TaskMainTypeModelEntity typeModel;
  String contents = ""; //任务内容
  File _imageFile;
  String _goodsSortName;
  final TextEditingController _codeController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _moneyController = TextEditingController();
  TextEditingController _limitController = TextEditingController();
  TextEditingController _peopleNumController = TextEditingController();
  String totalMoney = "";
  int count = 1;
  DateTime apply_end_time;
  DateTime work_end_time;
  String limit;
  String uuid="";
  String payInfo="";
  void _getImage() async {
    try {
      _imageFile = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxWidth: 800);
      setState(() {});
    } catch (e) {
      Toast.show("没有权限，无法打开相册！");
    }
  }

  @override
  void initState() {
    super.initState();
    _moneyController.addListener(moneyChangeListener);
    _peopleNumController.addListener(moneyChangeListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isScan) {
        _scan();
      }
    });
    uuid= SpUtil.getString(Constant.userId)+"_"+DateTime.now().toString();
    print(uuid);
  }

  void _scan() async {
    String code = await Utils.scan();
    if (code != null) {
      _codeController.text = code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: widget.isAdd ? "发布任务" : "编辑任务",
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                key: const Key('goods_edit_page'),
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    TextFieldItem(
                      title: "名称：",
                      hintText: "请填写任务名称",
                      controller: _titleController,
                    ),

                    ClickItem(
                      textAlign: TextAlign.start,
                      title: "内容：",
                      contentHint: "未填写",
                      content: getContent(),
                      onTap: () => NavigatorUtils.pushResult(context,
                          '${TaskRouter.taskPublishPage}?content=${Uri.encodeComponent(contents)}',
                          (result) {
                        setState(() {
                          contents = result;
                        });
                      }),
                    ),


                    Container(
                      margin: const EdgeInsets.only(left: 16.0),
                      child: Gaps.line,
                    ),
//自由定义item项
//                    Stack(
//                      alignment: Alignment.centerRight,
//                      children: <Widget>[
//                        TextFieldItem(
//                          controller: _codeController,
//                          title: "商品条码",
//                          hintText: "选填",
//                        ),
//                        Positioned(
//                          right: 16.0,
//                          child: GestureDetector(
//                            child: ThemeUtils.isDark(context) ?
//                            const LoadAssetImage("goods/icon_sm", width: 16.0, height: 16.0) :
//                            const LoadAssetImage("goods/scanning", width: 16.0, height: 16.0),
//                            onTap: _scan,
//                          ),
//                        )
//                      ],
//                    ),

////                    Gaps.vGap16,
////                    Gaps.vGap16,
////                    const Padding(
////                      padding: const EdgeInsets.only(left: 16.0),
////                      child: const Text(
////                        "折扣立减",
////                        style: TextStyles.textBold18,
////                      ),
////                    ),
////                    Gaps.vGap16,
////                    TextFieldItem(
////                        title: "立减金额",
////                        keyboardType: TextInputType.numberWithOptions(decimal: true)
////                    ),
////                    TextFieldItem(
////                        title: "折扣金额",
////                        keyboardType: TextInputType.numberWithOptions(decimal: true)
////                    ),
////                    Gaps.vGap16,
////                    Gaps.vGap16,
////                    const Padding(
////                      padding: const EdgeInsets.only(left: 16.0),
////                      child: const Text(
////                        "类型规格",
////                        style: TextStyles.textBold18,
////                      ),
////                    ),
//                    Gaps.vGap16,
                    ClickItem(
                      textAlign: TextAlign.start,
                      title: "任务类型：",
                      contentHint: "请选择任务类型",
                      content: getTaskType(),
                      onTap: () => _showBottomSheet(),
                    ),
                    ClickItem(
                        textAlign: TextAlign.start,
                        title: "申请截止时间：",
                        contentHint: "请选择任务申请截止时间",
                        content: apply_end_time==null?"":apply_end_time.toString().substring(0,apply_end_time.toString().length-4),
                        onTap: () => {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  onChanged: (date) {
                                //print('change $date');

                              }, onConfirm: (date) {
                                  setState(() {
                                    apply_end_time=date;
                                  });

                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.zh)
                            }
                    ),
                    ClickItem(
                        textAlign: TextAlign.start,
                        title: "提交截止时间：",
                        contentHint: "请选择任务提交截止时间",
                        content: work_end_time==null?"":work_end_time.toString().substring(0,work_end_time.toString().length-4),
                        onTap: () => {
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              onChanged: (date) {
                                //print('change $date');

                              }, onConfirm: (date) {
                                setState(() {
                                  work_end_time=date;
                                });

                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.zh)
                        }
                    ),

//                    TextFieldItem(
//                      title: "任务限制(选填)：",
//                      hintText: "任务限制",
//                      controller: _limitController,
//                    ),

                              TextFieldItem(
                                title: "奖励：",
                                hintText: "填写奖励/每人",
                                controller: _moneyController,
                              ),
//                    TextFieldItem(
//                      title: "人数(*)：",
//                      keyboardType: TextInputType.numberWithOptions(decimal: true),
//                      hintText: "填写所需的人数",
//                      controller: _peopleNumController,
//                    ),
                    TextFieldItem(
                      title: "人数：",
                      hintText: "填写总人数",
                      controller: _peopleNumController,
                    ),
//                    Row(
//                      children: <Widget>[
//                        Gaps.hGap16,
//                        Text("人数："),
//                        _reduceBtn(context),
//                        _countArea(),
//                        _addBtn(context)
//                      ],
//                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16.0),
                      child: Gaps.line,
                    ),
//                    ClickItem(
//                      textAlign: TextAlign.start,
//                      title: "默认所有任务最长审核时长不超过2（天）",
//                    )
                  ],
                ),
              ),
            ),
//            Padding(
//              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
//              child: MyButton(
//                onPressed: (){
//                  _createTask();
//                  //NavigatorUtils.goBack(context);
//                },
//                text: "提交",
//              ),
//            )
            Gaps.line,
            Row(
              children: [
                Expanded(child: Container()),
                Text("合计:"),
                Gaps.hGap5,
                Text("￥", style: TextStyle(color: Colours.red)),
                Text(totalMoney, style: TextStyle(color: Colours.red)),
                Gaps.hGap10,
                //圆角按钮
                FlatButton(
                  child: Container(
                    decoration: BoxDecoration(
                        // 设置圆角
                        borderRadius: BorderRadius.circular(6),
                        // 设置渐变色
                        gradient: LinearGradient(colors: <Color>[
                          Colours.app_main,
                          Colours.app_main
                        ])),
                    child: Text(
                      "提交订单",
                      style: TextStyle(color: Colours.material_bg),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  ),

                  //Text(actionName, key: const Key('actionName')),
                  //textColor: _overlayStyle == SystemUiOverlayStyle.light ? Colours.dark_text : Colours.text,
                  //highlightColor: Colors.transparent,
                  //flutter防抖技术
                  onPressed:
                  ()=> _createTask(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _showBottomSheet() {
    //暂时设置为1级分类
    NavigatorUtils.pushResult(context, TaskRouter.taskTypeChosePage, (result) {
      setState(() {
        typeModel = result;
        print("接收到返回值" + typeModel.name);
      });
    });
//    showModalBottomSheet(
//      context: context,
//      /// 使用true则高度不受16分之9的最高限制
//      isScrollControlled: true,
//      builder: (BuildContext context) {
//        return GoodsSortDialog(
//          onSelected: (_, name){
//            setState(() {
//              _goodsSortName = name;
//            });
//          },
//        );
//      },
//    );
  }
  Future<void> _createTask() async {
//    _readFileByte(Directory.systemTemp.path + "/quick_start.json").then((bytesData) async {
//
//
//
//    });


      if (!mounted) {
        return;
      }
        if (_titleController.text.isEmpty) {
          Toast.show("请填写标题");
          return;
        }

        if (contents.isEmpty) {
          Toast.show("请填写内容");
          return;
        }

        if (_moneyController.text.isEmpty) {
          Toast.show("请填写奖励金额");
          return;
        }

        if (_peopleNumController.text.isEmpty) {
          Toast.show("请填写人数");
          return;
        }

        if (typeModel == null) {
          Toast.show("请选择任务类型");
          return;
        }

        if (apply_end_time == null) {
          Toast.show("请选择任务申请截止时间");
          return;
        }

        if (work_end_time == null) {
          Toast.show("请选择提交任务截止时间");
          return;
        }

        Delta list = Delta.fromJson(json.decode(contents) as List);
        List<KeyValueItem> imageList = new List<KeyValueItem>();
        for (var item in list.toList()) {
          if (item.attributes != null && item.attributes.containsKey("embed")) {
            if (item.attributes["embed"]["type"] == "image") {
              var path = item.attributes["embed"]["source"].toString();
              var name =
              path.toString().substring(path.toString().lastIndexOf("/") + 1);
              var model = KeyValueItem();
              model.key = name;
              model.value = path;
              imageList.add(model);
              //MultipartFile multipartFile =  await MultipartFile.fromFile(path, filename:name);
            }
          }
        }

        List<MultipartFile> multipartImageList = new List<MultipartFile>();
        for (KeyValueItem item in imageList) {
          MultipartFile multipartFile = MultipartFile.fromBytes(
            await MFileUtils.readFileByte(item.value), //图片路径
            filename: item.key, //图片名称
          );
          print("读取" + item.key + "完毕");
          multipartImageList.add(multipartFile);
        }
        print("读取MultipartFile完毕");
        FormData formData = FormData.fromMap({
          "title": _titleController.text,
          "content": contents,
          "imageList": multipartImageList,
          "jiangLi": _moneyController.text,
          "peopleNum": _peopleNumController.text,
          "type": typeModel.id,
          "apply_end_time": apply_end_time.toString().substring(
              0, apply_end_time
              .toString()
              .length - 4),
          "work_end_time": work_end_time.toString().substring(0, work_end_time
              .toString()
              .length - 4),
          "limit": "",
          "mUUID": uuid
        });
        var price = double.parse(_moneyController.text) * count;
        //NavigatorUtils.push(context, StoreRouter.auditPage);
        await DioUtils.instance.requestNetwork<String>(
          Method.post,
          HttpApi.createTask,
          onSuccess: (data) {
            payInfo=data;
            NavigatorUtils.push(context,
                '${TaskRouter.taskPayPage}?pay=${Uri.encodeComponent(
                    data)}&price=$price');
          },
          onError: (code, msg) {
            Toast.show(msg);
          },
          params: formData,
        );

  }

//  Future<Uint8List> _readFileByte(String filePath) async {
//    Uri myUri = Uri.parse(filePath);
//    File audioFile = new File.fromUri(myUri);
//    Uint8List bytes;
//    await audioFile.readAsBytes().then((value) {
//      bytes = Uint8List.fromList(value);
//      print('reading of bytes is completed');
//    }).catchError((onError) {
//      print('Exception Error while reading audio from path:' +
//          onError.toString());
//    });
//    return bytes;
//  }

  String getTaskType() {
    if (typeModel == null) {
      return "";
    } else {
      return typeModel.name;
    }
  }

  String getContent() {
    if (contents.isEmpty) {
        return "";
    } else {
      return "已编辑";
    }
  }

  void moneyChangeListener() {
    moneyChange(count);
  }

  void moneyChange(int count) {
    if(_peopleNumController.text.isEmpty){
      totalMoney = "";
      setState(() {});
      return;
    }
    if (_moneyController.text.isEmpty) {
      totalMoney = "";
      setState(() {});

      return;
    }

    var price = double.parse(_moneyController.text) *  double.parse(_peopleNumController.text);
    totalMoney = price.toString();
    setState(() {});
  }

  //减少按钮
  Widget _reduceBtn(context) {
    return FlatButton(
      child: Container(
        decoration: BoxDecoration(
            // 设置圆角
            borderRadius: BorderRadius.circular(6),
            // 设置渐变色
            gradient: LinearGradient(
                colors: <Color>[Colours.app_main, Colours.app_main])),
        child: Text(
          "-",
          style: TextStyle(color: Colours.bg_gray),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
      ),

      //Text(actionName, key: const Key('actionName')),
      //textColor: _overlayStyle == SystemUiOverlayStyle.light ? Colours.dark_text : Colours.text,
      //highlightColor: Colors.transparent,
      onPressed: () => {moneyChange(--count)},
    );
  }

  //加号
  Widget _addBtn(context) {
    return //圆角按钮
        FlatButton(
      child: Container(
        decoration: BoxDecoration(
            // 设置圆角
            borderRadius: BorderRadius.circular(6),
            // 设置渐变色
            gradient: LinearGradient(
                colors: <Color>[Colours.app_main, Colours.app_main])),
        child: Text(
          "+",
          style: TextStyle(color: Colours.bg_gray),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
      ),

      //Text(actionName, key: const Key('actionName')),
      //textColor: _overlayStyle == SystemUiOverlayStyle.light ? Colours.dark_text : Colours.text,
      //highlightColor: Colors.transparent,
      onPressed: () => {moneyChange(++count)},
    );
  }

  //中间数量显示区域
  Widget _countArea() {
    return Container(
      alignment: Alignment.center, //上下左右居中
      color: Colors.white, //北京颜色 设置为白色
      child: Text(count.toString()), //先默认设置为1 因为后续是动态的获取数字
    );
  }
}
