
import 'package:flutter/material.dart';
import 'package:flutter_deer/mvp/base_page_presenter.dart';
import 'package:flutter_deer/net/net.dart';
import 'package:flutter_deer/shop/models/user_entity.dart';
import 'package:flutter_deer/shop/page/shop_page.dart';


class ShopPagePresenter extends BasePagePresenter<ShopPageState> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      /// 接口请求例子
      /// get请求参数queryParameters  post请求参数params
//      asyncRequestNetwork<UserEntity>(Method.get,
//        url: HttpApi.users,
//        onSuccess: (data){
//          data.name="心享";
//          view.setUser(data);
//          // 或
//          // view.provider.setUser(data);
//        },
//      );
      UserEntity data=new UserEntity();
      data.name="心享";
      data.avatarUrl="https://dss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=943737565,604373982&fm=111&gp=0.jpg";
      view.setUser(data);
    });
  }
 
}