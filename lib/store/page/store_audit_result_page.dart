
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/routers/routers.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_button.dart';

/// design/2店铺审核/index.html#artboard2
class StoreAuditResultPage extends StatefulWidget {
  @override
  _StoreAuditResultPageState createState() => _StoreAuditResultPageState();
}

class _StoreAuditResultPageState extends State<StoreAuditResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "支付结果",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Gaps.vGap50,
            const LoadAssetImage("store/icon_success",
              width: 80.0,
              height: 80.0,
            ),
            Gaps.vGap12,
            Text(
              "订单支付成功",
              style: TextStyles.textSize16,
            ),
            Gaps.vGap8,
            Text(
              "订单进入审核中",
              style: Theme.of(context).textTheme.subtitle,
            ),
            Gaps.vGap8,
            Text(
              "",
              style: Theme.of(context).textTheme.subtitle,
            ),
            Gaps.vGap12,
            Gaps.vGap12,
            MyButton(
              onPressed: (){
                NavigatorUtils.push(context, Routes.home, clearStack: true);
              },
              text: "进入首页",
            )
          ],
        ),
      ),
    );
  }
}
