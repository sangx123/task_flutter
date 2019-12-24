
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:sticky_headers/sticky_headers.dart';

/// design/6店铺-账户/index.html#artboard19
class WithdrawalRecordListPage extends StatefulWidget {
  @override
  _WithdrawalRecordListPageState createState() => _WithdrawalRecordListPageState();
}

class _WithdrawalRecordListPageState extends State<WithdrawalRecordListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "提现记录",
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
            Text(i % 2 == 0 ? "微信（唯鹿）" : "工商（尾号:4562 李一）"),
            Positioned(
                top: 0.0,
                right: 0.0,
                child: Text("-10.00", style: TextStyles.textBold14)
            ),
            Positioned(
                bottom: 0.0,
                left: 0.0,
                child: Text(i % 2 == 0 ? "12:40:20" : "12:50:20", style: Theme.of(context).textTheme.subtitle)
            ),
            Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Text(i % 2 == 0 ? "审核失败" : "待审核", style: i % 2 == 0 ? TextStyle(
                    fontSize: Dimens.font_sp12,
                    color: Theme.of(context).errorColor
                ) : const TextStyle(
                    fontSize: Dimens.font_sp12,
                    color: Color(0xFFFF8547)
                ))
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
