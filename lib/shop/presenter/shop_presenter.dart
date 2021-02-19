
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/mvp/base_page_presenter.dart';
import 'package:flutter_deer/net/net.dart';
import 'package:flutter_deer/shop/models/user_entity.dart';
import 'package:flutter_deer/shop/page/shop_page.dart';
import 'package:flutter_deer/util/toast.dart';


class ShopPagePresenter extends BasePagePresenter<ShopPageState> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      //此处应该只请求一次
      /// 接口请求例子
      /// get请求参数queryParameters  post请求参数params
//      DioUtils.instance.requestNetwork<UserEntity>(Method.get,
//        url: HttpApi.getUserInfo,
//        onSuccess: (data){
//          data.name="心享";
//          view.setUser(data);
//          // 或
//          // view.provider.setUser(data);
//        },
//      );

        getUserInfo();
//      UserEntity data=new UserEntity();
//      data.name="心享";
//      data.avatarUrl="https://dss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=943737565,604373982&fm=111&gp=0.jpg";
//      view.setUser(data);
    });
  }


  Future<void> getUserInfo() async {
    await DioUtils.instance.requestNetwork<UserEntity>(
      Method.get,
      HttpApi.getUserInfo,
      onSuccess: (data) {
        view.provider.setUser(data);
        //设置最新的userInfo
        SpUtil.putObject(Constant.userInfo, data);
      },
      onError: (code, msg) {
        Toast.show(msg);
      },
    );
  }
 
}