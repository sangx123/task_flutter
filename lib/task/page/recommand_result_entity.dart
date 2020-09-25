import 'package:flutter_deer/generated/json/base/json_convert_content.dart';

class RecommandResultEntity with JsonConvert<RecommandResultEntity> {
	int id;
	int userid;
	String createTime;
	String title;
	String content;
	double workerPrice;
	int state;
	String username;
	int needpeoplenum;
}
