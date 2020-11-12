import 'package:flutter_deer/generated/json/base/json_convert_content.dart';

class MyJieShouEntity with JsonConvert<MyJieShouEntity> {
	dynamic id;
	dynamic userId;
	dynamic businessTaskId;
	dynamic userTaskStatus;
	dynamic userApplyTaskTime;
	dynamic businessAgreeApplyTime;
	dynamic userFirstSubmitTaskTime;
	dynamic userFirstSubmitTaskContent;
	dynamic businessAuditFirstTime;
	dynamic businessAuditFirstResult;
	dynamic userSecondSubmitTaskTime;
	dynamic userSecondSubmitTaskContent;
	dynamic businessAuditSecondTime;
	dynamic businessAuditSecondResult;
	dynamic userQuitTask;
	MyJieShouTask task;
	String name;
}

class MyJieShouTask with JsonConvert<MyJieShouTask> {
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
	dynamic userTaskList;
}
