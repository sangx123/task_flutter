import 'package:flutter_deer/generated/json/base/json_convert_content.dart';
import 'package:flutter_deer/order/models/search_entity.dart';
import 'package:flutter_deer/shop/models/user_entity.dart';
import 'package:flutter_deer/task/models/recommand_result_entity.dart';

import 'net/login_entity.dart';

class EntityFactory {
  //entity的转换工厂
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "SearchEntity") {
      return SearchEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginEntity") {
      return new LoginEntity().fromJson(json) as T;
    } else if (T.toString() == "RecommandResultEntity") {
      return  new RecommandResultEntity().fromJson(json) as T;
    } else {
      return null;
    }
  }
}