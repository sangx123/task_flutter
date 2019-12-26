import 'dart:io';

import 'package:dio/dio.dart';

class ExceptionHandle {
  static const String success = "200";
  static const String success_not_content = "204";
  static const String unauthorized = "401";
  static const String forbidden = "403";
  static const String not_found = "404";

  static const String net_error = "1000";
  static const String parse_error = "1001";
  static const String socket_error = "1002";
  static const String http_error = "1003";
  static const String timeout_error = "1004";
  static const String cancel_error = "1005";
  static const String unknown_error = "9999";

  static NetError handleException(dynamic error){
    print(error);
    if (error is DioError){
      if (error.type == DioErrorType.DEFAULT || 
          error.type == DioErrorType.RESPONSE){
        dynamic e = error.error;
        if (e is SocketException){
          return NetError(socket_error, "网络异常，请检查你的网络！");
        }
        if (e is HttpException){
          return NetError(http_error, "服务器异常！");
        }
        return NetError(net_error, "网络异常，请检查你的网络！");
      }else if (error.type == DioErrorType.CONNECT_TIMEOUT ||
          error.type == DioErrorType.SEND_TIMEOUT ||
          error.type == DioErrorType.RECEIVE_TIMEOUT){
        return NetError(timeout_error, "连接超时！");
      }else if (error.type == DioErrorType.CANCEL){
        return NetError(cancel_error, "取消请求");
      }else{
        return NetError(unknown_error, "未知异常");
      }
    }else {
      return NetError(unknown_error, "未知异常");
    }
  }
}

class NetError{
  String code;
  String msg;

  NetError(this.code, this.msg);
}