
import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/order/widgets/pay_type_dialog.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/task/models/recommand_result_new_entity.dart';
import 'package:flutter_deer/task/task_router.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/my_card.dart';

import '../shop_router.dart';


class MyFabuTaskItemPage extends StatelessWidget {

  const MyFabuTaskItemPage({
    Key key,
    @required this.tabIndex,
    @required this.index,
    @required this.model,
  }) : super(key: key);

  final int tabIndex;
  final int index;
  final RecommandResultNewEntity model;
  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle = Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    bool isDark = ThemeUtils.isDark(context);
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: MyCard(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () => NavigatorUtils.push(context, '${ShopRouter.myFabuUserTaskManagerHome}?taskId=${model.id}'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(model.createTime,),
                    ),
                    Text(
                      model.workerPrice.toString(),
                      style: TextStyle(
                          fontSize: Dimens.font_sp12,
                          color: Theme.of(context).errorColor
                      ),
                    ),
                  ],
                ),
                Gaps.vGap8,
                Text(
                  model.title,
                  style: Theme.of(context).textTheme.subtitle,
                ),
                Gaps.vGap12,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                            style: textTextStyle,
                            children: <TextSpan>[
                              TextSpan(text: '发布日期'),
                              //TextSpan(text: '  共3件商品', style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: Dimens.font_sp10)),
                            ],
                          )
                      ),
                    ),
                    Text(
                      model.createTime,
                      style: TextStyles.textSize12,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
