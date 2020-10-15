import 'package:flutter_deer/generated/json/base/json_convert_content.dart';

class TaskMainTypeModelEntity with JsonConvert<TaskMainTypeModelEntity> {
	int id;
	String name;
	bool selected=false;
}
