
import 'package:flutter_deer/common/common.dart';

import '../entity_factory.dart';

class BaseEntity<T>{

  //int code;
  String respCode;
  String respMsg;
  //String message;
  T data;
  List<T> listData = [];

  BaseEntity(this.respCode, this.respMsg, this.data);

  BaseEntity.fromJson(Map<String, dynamic> json) {
    //code = json[Constant.code];
    respCode = json[Constant.respCode];
    respMsg = json[Constant.respMsg];
    if (json.containsKey(Constant.data)){
      if (json[Constant.data] is List) {
        (json[Constant.data] as List).forEach((item){
          listData.add(_generateOBJ<T>(item));
        });
      }else {
        data = _generateOBJ(json[Constant.data]);
      }
    }
  }

  S _generateOBJ<S>(json) {
    if (S.toString() == "String"){
      return json.toString() as S;
    }else if (T.toString() == "Map<dynamic, dynamic>"){
      return json as S;
    }else {
      return EntityFactory.generateOBJ(json);
    }
  }
}