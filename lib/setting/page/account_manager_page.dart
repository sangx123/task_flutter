
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flustars/flustars.dart' hide MyAppBar;
import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/event/event_bus_utils.dart';
import 'package:flutter_deer/event/event_user.dart';
import 'package:flutter_deer/login/login_router.dart';
import 'package:flutter_deer/net/dio_utils.dart';
import 'package:flutter_deer/net/http_api.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/models/user_entity.dart';
import 'package:flutter_deer/shop/provider/user_provider.dart';
import 'package:flutter_deer/util/file_utils.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/click_item.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


/// design/8设置/index.html#artboard1
class AccountManagerPage extends StatefulWidget {
  @override
  _AccountManagerPageState createState() => _AccountManagerPageState();
}

class _AccountManagerPageState extends State<AccountManagerPage> {




  File _imageFile;
  String photoUrl="";

  @override
  void initState() {
    super.initState();
    //初始化eventbus并且监听事件
    var user= UserEntity.fromJson(SpUtil.getObject(Constant.userInfo));
    photoUrl=user.avatar;
  }

  void _getImage() async{
    //try {
      _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 800, imageQuality: 95);
      //上传图像
      print(_imageFile.path);
      List<MultipartFile> multipartImageList = new List<MultipartFile>();
      MultipartFile multipartFile = MultipartFile.fromBytes(
        await MFileUtils.readFileByUri(_imageFile.uri), //图片路径
        filename: _imageFile.path.toString().substring(_imageFile.path.toString().lastIndexOf("/") + 1), //图片名称
      );
      multipartImageList.add(multipartFile);

      print("读取MultipartFile完毕");
      FormData formData = FormData.fromMap({
        "imageList": multipartImageList
      });
      //NavigatorUtils.push(context, StoreRouter.auditPage);
      await DioUtils.instance.requestNetwork<String>(
        Method.post,
        HttpApi.uploadHeadImage,
        onSuccess: (data) {
          photoUrl=data;
          Toast.show("图片上传成功！");
          //更新UserEntity的数据
          UserEntity user= UserEntity.fromJson(SpUtil.getObject(Constant.userInfo));
          user.avatar=photoUrl;
          SpUtil.putObject(Constant.userInfo,user);
          //发送修改图像的事件
          EventBusUtils.instance.emit(EventUserParam(user));

          setState(() {});
        },
        onError: (code, msg) {
          Toast.show(msg);
        },
        params: formData,
      );
//    } catch (e) {
//      Toast.show("没有权限，无法打开相册！");
//    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: "个人资料",
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClickItem(
                title: "头像",
              ),
              Positioned(
                top: 8.0,
                bottom: 8.0,
                right: 40.0,
                child:  InkWell(
                  onTap: _getImage,
                  child:
                CircleAvatar(
                    radius: 17.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: ImageUtils.getImageProvider(photoUrl, holderImg: 'shop/tx')
                ),)


              )
            ],
          ),
//          ClickItem(
//              title: "修改密码",
//              onTap: () => NavigatorUtils.push(context, LoginRouter.updatePasswordPage)
//          ),
          ClickItem(
              title: "手机号",
              content: SpUtil.getString(Constant.phone),
          ),
        ],
      ),
    );
  }
//  @override
//  void deactivate() {
//    super.deactivate();
//    /// 必须在deactivate方法中声明 才可以保证事件不会因为bus移除事件而无法推送
//    bus.on("flush", (arg) {
//      print("");
//    });
//  }
}
