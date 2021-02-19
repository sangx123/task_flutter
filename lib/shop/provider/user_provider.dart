
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/shop/models/user_entity.dart';

class UserProvider extends ChangeNotifier {

  UserEntity _user;
  UserEntity get user => _user;
  
  void setUser(UserEntity user) {
    _user = user;
    notifyListeners();
  }


  void setAvaterUrl(String url){
     SpUtil.putString(Constant.avater,url);
     if(_user!=null){
       _user.avatar=url;
       notifyListeners();
     }
  }
}