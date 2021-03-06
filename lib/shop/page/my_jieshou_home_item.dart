import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/order/widgets/pay_type_dialog.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/models/my_jie_shou_entity.dart';
import 'package:flutter_deer/task/models/home_task_list_entity.dart';
import 'package:flutter_deer/task/models/recommand_result_new_entity.dart';
import 'package:flutter_deer/task/task_router.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_card.dart';

import '../../config.dart';

class MyJieShouHomeItemPage extends StatelessWidget {
  const MyJieShouHomeItemPage({
    Key key,
    @required this.tabIndex,
    @required this.index,
    @required this.model,
  }) : super(key: key);

  final int tabIndex;
  final int index;
  final MyJieShouEntity model;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;
    Color _shadowColor;
    bool isDark = ThemeUtils.isDark(context);
    _backgroundColor = isDark ? Colours.dark_bg_gray_ : Colors.white;
    _shadowColor = isDark ? Colors.transparent : const Color(0xFFF1F1F1);
    return Container(
        margin: const EdgeInsets.only(top: 8.0),
        child: MyCard(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () =>_toNext(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          model.task.title,
                          style: TextStyle(
                              fontSize: Dimens.font_sp15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            Config.getTaskStatus(model.userTaskStatus.toString()),
                            style: TextStyle(
                                fontSize: Dimens.font_sp15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).errorColor),
                          ),
                          Text("",
                              style: TextStyle(fontSize: Dimens.font_sp12)),
                        ],
                      ),
                    ],
                  ),
                  Gaps.vGap10,
                  Text(
                    Utils.formatPrice(model.task.workerPrice.toString()),
                    style: TextStyle(
                        fontSize: Dimens.font_sp15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).errorColor),
                  ),
                  Gaps.vGap10,
                  Row(
                    children: <Widget>[
                      Text("报名截止时间:    ",
                          style: TextStyle(fontSize: Dimens.font_sp12)),
                      Text(model.task.applyEndTime,
                          style: TextStyle(
                            fontSize: Dimens.font_sp14,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }


  void _toNext(BuildContext context) {
    var model=HomeTaskListUserTaskList();
    model.id=this.model.id;
    model.userId=this.model.userId;
    model.businessTaskId=this.model.businessTaskId;
    model.userTaskStatus=this.model.userTaskStatus;
    model.userApplyTaskTime=this.model.userApplyTaskTime;
    model.businessAgreeApplyTime=this.model.businessAgreeApplyTime;
    model.userFirstSubmitTaskTime=this.model.userFirstSubmitTaskTime;
    model.userFirstSubmitTaskContent=this.model.userFirstSubmitTaskContent;
    model.businessAuditFirstTime=this.model.businessAuditFirstTime;
    model.businessAuditFirstResult=this.model.businessAuditFirstResult;
    model.userSecondSubmitTaskTime=this.model.userSecondSubmitTaskTime;
    model.userSecondSubmitTaskContent=this.model.userSecondSubmitTaskContent;
    model.businessAuditSecondTime=this.model.businessAuditSecondTime;
    model.businessAuditSecondResult=this.model.businessAuditSecondResult;
    model.userQuitTask=this.model.userQuitTask;
    model.name=this.model.name;
    Config.goNext(context,model);
  }
}


