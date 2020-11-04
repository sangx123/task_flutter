import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/order/order_router.dart';
import 'package:flutter_deer/order/widgets/pay_type_dialog.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/task/models/home_task_list_entity.dart';
import 'package:flutter_deer/task/models/recommand_result_new_entity.dart';
import 'package:flutter_deer/task/task_router.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_card.dart';

import '../shop_router.dart';

class MyFabuUserTaskItemPage extends StatelessWidget {
  const MyFabuUserTaskItemPage({
    Key key,
    @required this.tabIndex,
    @required this.index,
    @required this.model,
  }) : super(key: key);

  final int tabIndex;
  final int index;
  final HomeTaskListUserTaskList model;

  @override
  Widget build(BuildContext context) {

    Color _backgroundColor;
    Color _shadowColor;
    bool isDark = ThemeUtils.isDark(context);
    _backgroundColor = isDark ? Colours.dark_bg_gray_ : Colors.white;
    _shadowColor = isDark ? Colors.transparent : const Color(0xFFF1F1F1);
    final TextStyle textTextStyle =
        Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    //bool isDark = ThemeUtils.isDark(context);
    return DecoratedBox(
        decoration: BoxDecoration(
            color: _backgroundColor,
            border: Border(
              bottom: Divider.createBorderSide(context, width: 1,color: _shadowColor),
            )
        ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () => NavigatorUtils.push(context, OrderRouter.orderInfoPage),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const ClipOval(
                        child: LoadImage('order/icon_avatar', width: 44.0, height: 44.0),
                      ),
                      Gaps.hGap8,
                      Expanded(
                        // 合并Text的语义
                        child: MergeSemantics(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text('郭李'),
                              Gaps.vGap8,
                              const Text('15000000000'),
                            ],
                          ),
                        ),
                      ),
                      //Gaps.hGap16,
                      Text(
                        getTaskStatus(model.userTaskStatus.toString()),
                        style: TextStyle(
                            fontSize: Dimens.font_sp16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).errorColor),
                      ),
                    ],
                  ),
//                  Row(
//                    children: <Widget>[
//                      Expanded(
//                        child: Text(
//                          model.userApplyTaskTime,
//                        ),
//                      ),
//                      Text(
//                        getTaskStatus(model.userTaskStatus.toString()),
//                        style: TextStyle(
//                            fontSize: Dimens.font_sp12,
//                            color: Theme.of(context).errorColor),
//                      ),
//                    ],
//                  ),
//                  Gaps.vGap8,
//                  Row(children: <Widget>[
//                    Expanded(
//                      child: Text(
//                        model.id.toString(),
//                        style: Theme.of(context).textTheme.subtitle,
//                      ),
//                    ),
//                  ]),
//                  Gaps.vGap12,
//                  Row(
//                    children: <Widget>[
//                      Expanded(
//                        child: RichText(
//                            text: TextSpan(
//                          style: textTextStyle,
//                          children: <TextSpan>[
//                            TextSpan(text: '发布日期'),
//                            //TextSpan(text: '  共3件商品', style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: Dimens.font_sp10)),
//                          ],
//                        )),
//                      ),
//                      Text(
//                        model.userApplyTaskTime,
//                        style: TextStyles.textSize12,
//                      ),
//                    ],
//                  ),
                ],
              ),
            ),
          ),
        );
  }

  String getTaskStatus(String status) {
    String result = "";
    switch (status) {
      case "0":
        result = "申请中";
        break;
      case "1":
        result = "用户待提交";
        break;
      case "2":
        result = "用户待提交超时";
        break;
      case "3":
        result = "用户已提交待审核";
        break;
      case "4":
        result = "商户审核超时";
        break;
      case "5":
        result = "商户审核成功";
        break;
      case "6":
        result = "商户审核失败";
        break;
      case "7":
        result = "用户申诉中";
        break;
      case "8":
        result = "商户申诉审核超时";
        break;
      case "9":
        result = "商户申诉审核成功";
        break;
      case "10":
        result = "商户申诉审核失败";
        break;
    }
    return result;
  }
}
