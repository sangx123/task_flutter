
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flustars/flustars.dart' as flutter_stars;
import 'package:flutter_deer/common/themes.dart';
import 'package:flutter_deer/net/dio_utils.dart';
import 'package:flutter_deer/net/http_api.dart';
import 'package:flutter_deer/provider/theme_provider.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/task/page/task_main_type_model_entity.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class TaskTypeChosePage extends StatefulWidget {
  @override
  _TaskTypeChosePageState createState() => _TaskTypeChosePageState();
}

class _TaskTypeChosePageState extends State<TaskTypeChosePage> {
  List<TaskMainTypeModelEntity> _list = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await flutter_stars.SpUtil.getInstance();
    });
    _getMainType();
  }
  ///下拉刷新
  Future<void> _getMainType() async {
    await DioUtils.instance.requestNetwork<TaskMainTypeModelEntity>(
        Method.post, HttpApi.getTaskMainType, isList: true, onSuccessList: (data) {
        setState(() {
          _list.clear();
          _list.addAll(data);

        });
    }, onError: (code, msg) {
        setState(() {
          Toast.show(msg);
        });
    }, params: {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colours.bg_color ,
      appBar:  MyAppBar(
          title: "请选择任务分类",
          actionName: "完成",
          onPressed:()=>_save(context),
      ),


      body:
         ListView.separated(
          shrinkWrap: true,
          itemCount: _list.length,
          separatorBuilder: (_, index) {
            return const Divider();
          },
          itemBuilder: (_, index){
            return InkWell(
              onTap: ()=>onItemClick(index),
              child: Container(
                color: Colors.white,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                height: 50.0,
                child: Row(
                  children: <Widget>[

                    Expanded(
                      child: Text(_list[index].name),
                    ),
                    Opacity(
                        opacity: _list[index].selected?1:0,
                        child: Icon(Icons.done, color: Colors.blue)
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  onItemClick(int index) {
    print("onItemClick"+index.toString()+_list[index].name);
    for(int i=0;i<_list.length;i++){
      _list[i].selected=i==index;

    }
    setState(() {

    });
//    //延时执行此操作
//    Future.delayed(Duration(milliseconds: 5)).then((e) {
//
//    });
  }

  //保存并返回数据
  _save(BuildContext context){
    TaskMainTypeModelEntity  model;
    for(int i=0;i<_list.length;i++){
      if(_list[i].selected==true){
        model=_list[i];
        break;
      }
    }

    if(model==null){
      Toast.show("请选择任务分类");
      return;
    }
    NavigatorUtils.goBackWithParams(context,model);

  }
}



