
import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/order/widgets/pay_type_dialog.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/task/models/recommand_result_new_entity.dart';
import 'package:flutter_deer/task/task_router.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_card.dart';


class TaskRecommandItemPage extends StatelessWidget {

  const TaskRecommandItemPage({
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
    Color _backgroundColor;
    Color _shadowColor;
    bool isDark = ThemeUtils.isDark(context);
     _backgroundColor = isDark ? Colours.dark_bg_gray_ : Colors.white;
    _shadowColor = isDark ? Colors.transparent : const Color(0x80DCE7FA);
//    return Container(
//      margin: const EdgeInsets.only(top: 8.0),
//      child: MyCard(
//        child: Container(
//          padding: const EdgeInsets.all(16.0),
//          child: InkWell(
//            onTap: () => NavigatorUtils.push(context, '${TaskRouter.taskDetailPage}?taskId=${model.id}'),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    Expanded(
//                      child:Row(children: [
//                        CircleAvatar(
//                            radius: 28.0,
//                            backgroundColor: Colors.transparent,
//                            backgroundImage: ImageUtils.getImageProvider("https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2415100391,2445796972&fm=26&gp=0.jpg", holderImg: 'shop/tx')
//                        ),
//                      ],
//                      )
//
//                      //Text(model.createTime,),
//                    ),
//                    Text(
//                      model.workerPrice.toString(),
//                      style: TextStyle(
//                          fontSize: Dimens.font_sp12,
//                          color: Theme.of(context).errorColor
//                      ),
//                    ),
//                  ],
//                ),
//                Gaps.vGap8,
//                Text(
//                  model.title,
//                  style: Theme.of(context).textTheme.subtitle,
//                ),
//                Gaps.vGap12,
//                Row(
//                  children: <Widget>[
//                    Expanded(
//                      child: RichText(
//                          text: TextSpan(
//                            style: textTextStyle,
//                            children: <TextSpan>[
//                              TextSpan(text: '发布日期'),
//                              //TextSpan(text: '  共3件商品', style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: Dimens.font_sp10)),
//                            ],
//                          )
//                      ),
//                    ),
//                    Text(
//                      model.createTime,
//                      style: TextStyles.textSize12,
//                    ),
//                  ],
//                ),
//              ],
//            ),
//          ),
//        ),
//      )
//    );

  return  DecoratedBox(
      decoration: BoxDecoration(
          color: _backgroundColor,
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.8,color: _shadowColor),
          )
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LoadImage("", width: 72.0, height: 72.0),
            Gaps.hGap8,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   Text(
                      model.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis
                  ),
                  Gaps.vGap4,
//                  Row(
//                    children: <Widget>[
//                      Offstage(
//                        // 类似于gone
//                        offstage: item.type % 3 != 0,
//                        child: Container(
//                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                          margin: const EdgeInsets.only(right: 4.0),
//                          decoration: BoxDecoration(
//                            color: Theme.of(context).errorColor,
//                            borderRadius: BorderRadius.circular(2.0),
//                          ),
//                          height: 16.0,
//                          alignment: Alignment.center,
//                          child: const Text(
//                            "立减",
//                            style: TextStyle(
//                                color: Colors.white,
//                                fontSize: Dimens.font_sp10
//                            ),
//                          ),
//                        ),
//                      ),
//                      Opacity(
//                        // 修改透明度实现隐藏，类似于invisible
//                        opacity: item.type % 2 != 0 ? 0.0 : 1.0,
//                        child: Container(
//                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                          decoration: BoxDecoration(
//                            color: Theme.of(context).primaryColor,
//                            borderRadius: BorderRadius.circular(2.0),
//                          ),
//                          height: 16.0,
//                          alignment: Alignment.center,
//                          child: const Text(
//                            "社区币抵扣",
//                            style: TextStyle(
//                                color: Colors.white,
//                                fontSize: Dimens.font_sp10
//                            ),
//                          ),
//                        ),
//                      )
//                    ],
//                  ),
                  Gaps.vGap16,
                  const Text("¥20.00")
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(model.workerPrice.toString()),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    "特产美味",
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );

  }
}
