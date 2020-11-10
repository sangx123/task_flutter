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

import '../../config.dart';
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
              onTap: ()=> Config.goNext(context,model),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Gaps.hGap8,
                      Expanded(
                        // 合并Text的语义
                        child: MergeSemantics(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text((model==null)?"":model.name ,style: TextStyle(
                              fontSize: Dimens.font_sp16,
                              fontWeight: FontWeight.bold),),
                              Gaps.vGap8,
                              Text((model==null)?"":Config.getTaskStatusTime(model)),
                            ],
                          ),
                        ),
                      ),
                      //Gaps.hGap16,
                      Text(
                        (model==null)?"":Config.getTaskStatus(model.userTaskStatus.toString()),
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
}
