
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:sticky_headers/sticky_headers.dart';

/// design/6店铺-账户/index.html#artboard1
class AccountRecordListPage extends StatefulWidget {
  @override
  _AccountRecordListPageState createState() => _AccountRecordListPageState();
}

class _AccountRecordListPageState extends State<AccountRecordListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: "账户流水",
      ),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (_, index){
          return StickyHeader(
            header: Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              color: ThemeUtils.getStickyHeaderColor(context),
              padding: const EdgeInsets.only(left: 16.0),
              height: 34.0,
              child: Text("2018/06/0${index + 1}"),
            ),
            content: _buildItem(index),
          );
        },
      ),
    );
  }
  
  Widget _buildItem(int index){
    List<Widget> list = List.generate(index + 1, (i){
      return Container(
        height: 72.0,
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            border: Border(
              bottom: Divider.createBorderSide(context, width: 0.8),
            )
        ),
        child: Stack(
          children: <Widget>[
            Text(i % 2 == 0 ? "采购订单结算营收" : "提现"),
            Positioned(
                top: 0.0,
                right: 0.0,
                child: Text(i % 2 == 0 ? "+10.00" : "-10.00", style: i % 2 == 0 ? TextStyle(
                    color: Theme.of(context).errorColor,
                    fontWeight: FontWeight.bold
                ) : TextStyles.textBold14)
            ),
            Positioned(
                bottom: 0.0,
                left: 0.0,
                child: Text(i % 2 == 0 ? "18:20:10" : "18:20:11", style: Theme.of(context).textTheme.subtitle)
            ),
            Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Text("余额：20.00", style: Theme.of(context).textTheme.subtitle)
            ),
          ],
        ),
      );
    });
    return Column(
      children: list
    );
  }
}
