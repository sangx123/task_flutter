
import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/order/widgets/pay_type_dialog.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/task/task_router.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/my_card.dart';


class TaskRecommandItemPage extends StatelessWidget {

  const TaskRecommandItemPage({
    Key key,
    @required this.tabIndex,
    @required this.index,
  }) : super(key: key);

  final int tabIndex;
  final int index;
  
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
            //onTap: () => NavigatorUtils.push(context, TaskRouter.taskDetailPage),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("15000000000（郭李）",),
                    ),
                    Text(
                      "货到付款",
                      style: TextStyle(
                          fontSize: Dimens.font_sp12,
                          color: Theme.of(context).errorColor
                      ),
                    ),
                  ],
                ),
                Gaps.vGap8,
                Text(
                  "西安市雁塔区 鱼化寨街道唐兴路唐兴数码3楼318",
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
                      "2018.02.05 10:00",
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
