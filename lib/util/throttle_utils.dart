import 'dart:async';

import 'package:flutter_deer/util/log_utils.dart';
import 'package:flutter_deer/util/toast.dart';

class ThrottleClick {
  static Function throttle(Future Function() func) {
    if (func == null) {
      return func;
    }
    bool enable = true;
    Function target = () {
      if (enable == true) {
        enable = false;
        func().then((_) {
          enable = true;
        });
      }
    };
    return target;
  }

  /// 函数防抖
  ///
  /// [func]: 要执行的方法
  /// [delay]: 要迟延的时长
  static Function debounce(
    Function func, [
    Duration delay = const Duration(milliseconds: 2000),
  ]) {
    Timer timer;
    Function target = () {
      if (timer?.isActive ?? false) {
        timer?.cancel();
      }
      timer = Timer(delay, () {
        func?.call();
      });
    };
    return target;
  }

  static DateTime lastPopTime;
  static Function throttleClick(Future Function() func){
    if (func == null) {
      return func;
    }
    Function target = () {
      // 防重复提交
      if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)){
        lastPopTime = DateTime.now();
        print("goFunc()");
        func();
      }else{
        lastPopTime = DateTime.now();
        print("lastPopTime="+lastPopTime.toString());
        //Toast.show("请勿重复点击！");
      }
    };
    return target;

  }
}
