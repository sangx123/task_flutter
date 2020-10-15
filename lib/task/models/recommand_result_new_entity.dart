import 'package:flutter_deer/generated/json/base/json_convert_content.dart';

class RecommandResultNewEntity with JsonConvert<RecommandResultNewEntity> {
	int id;
	int userid;
	String createTime;
	String title;
	String content;
	double workerPrice;
	int needpeoplenum;
	int payStatus;
	int status;
	double needtotalpay;
	int typeid;
	String taskLimit;
	String applyEndTime;
	String workEndTime;
	int aduitTime;
	String orderid;
}
