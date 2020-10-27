import 'package:flutter_deer/generated/json/base/json_convert_content.dart';
import 'package:flutter_deer/order/models/search_entity.dart';
import 'package:flutter_deer/shop/models/user_entity.dart';
import 'package:flutter_deer/task/models/home_task_list_entity.dart';
import 'package:flutter_deer/task/models/recommand_result_new_entity.dart';
import 'package:flutter_deer/task/models/task_main_type_model_entity.dart';

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
    } else if (T.toString() == "RecommandResultNewEntity") {
      return  new RecommandResultNewEntity().fromJson(json) as T;
    } else if (T.toString() == "TaskMainTypeModelEntity") {
      return  new TaskMainTypeModelEntity().fromJson(json) as T;
    }else if(T.toString() == "HomeTaskListEntity"){
      return  new HomeTaskListEntity().fromJson(json) as T;
    } else if(T.toString() == "HomeTaskListUserTaskList"){
      return  new HomeTaskListUserTaskList().fromJson(json) as T;
    }else {
      return null;
    }
  }
}


