// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter_deer/task/models/recommand_result_entity.dart';
import 'package:flutter_deer/generated/json/recommand_result_entity_helper.dart';
import 'package:flutter_deer/task/page/task_main_type_model_entity.dart';
import 'package:flutter_deer/generated/json/task_main_type_model_entity_helper.dart';
import 'package:flutter_deer/net/login_entity.dart';
import 'package:flutter_deer/generated/json/login_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {			case RecommandResultEntity:
			return recommandResultEntityFromJson(data as RecommandResultEntity, json) as T;			case TaskMainTypeModelEntity:
			return taskMainTypeModelEntityFromJson(data as TaskMainTypeModelEntity, json) as T;			case LoginEntity:
			return loginEntityFromJson(data as LoginEntity, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {			case RecommandResultEntity:
			return recommandResultEntityToJson(data as RecommandResultEntity);			case TaskMainTypeModelEntity:
			return taskMainTypeModelEntityToJson(data as TaskMainTypeModelEntity);			case LoginEntity:
			return loginEntityToJson(data as LoginEntity);    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {			case 'RecommandResultEntity':
			return RecommandResultEntity().fromJson(json);			case 'TaskMainTypeModelEntity':
			return TaskMainTypeModelEntity().fromJson(json);			case 'LoginEntity':
			return LoginEntity().fromJson(json);    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {
      case 'RecommandResultEntity':
			return List<RecommandResultEntity>();
			case 'TaskMainTypeModelEntity':
			return List<TaskMainTypeModelEntity>();
			case 'LoginEntity':
			return List<LoginEntity>();    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}