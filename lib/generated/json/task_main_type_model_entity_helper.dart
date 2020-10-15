import 'package:flutter_deer/task/models/task_main_type_model_entity.dart';

taskMainTypeModelEntityFromJson(TaskMainTypeModelEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	data.selected=false;
	return data;
}

Map<String, dynamic> taskMainTypeModelEntityToJson(TaskMainTypeModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['selected=false'] = entity.selected=false;
	return data;
}