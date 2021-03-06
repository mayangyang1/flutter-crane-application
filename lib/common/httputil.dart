import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../config/base_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/toast.dart';

class HttpUtil {
  static void get(
    String url,
    BuildContext context,
    {
      Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error
    }
  ) async {

    //数据拼接
    if(data != null && data.isNotEmpty) {
      StringBuffer options = new StringBuffer('?');
      data.forEach((key, value) {
        options.write('$key=$value&');
      });
      String optionsStr = options.toString();
      optionsStr = optionsStr.substring(0, optionsStr.length - 1);
      url += optionsStr;
    }
    
    //发送get请求
    await _sendRequest(
      url,
      context,
      'get',
      success,
      headers: headers,
      error: error
    );
  }

  static void post(
    String url,
    BuildContext context,
    {
      Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error,
    }
  ) async {

    //发送post请求
    await _sendRequest(
      url,
      context,
      'post',
      success,
      data: data,
      headers: headers,
      error: error
    );
  }

  //请求处理
  static Future _sendRequest(
    String url,
    BuildContext context,
    String method,
    Function success,
    {
      Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function error
    }
  ) async {

    url = HttpConfig.url + url;

    try {
      Map<String, dynamic> dataMap = data == null ? new Map() : data;
      Map<String, dynamic> headersMap = headers == null? new Map() : headers;

      //配置dio请求信息
      Response response;
      Dio dio = new Dio();
      dio.options.connectTimeout = 10000;//服务器连接超时
      dio.options.receiveTimeout = 10000;//响应流上前后两次接收到的数据间隔
      dio.options.headers.addAll(headersMap);
      //拦截器
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: ( RequestOptions options) {
          //请求拦截器
          dio.lock();
          Future<dynamic> future = Future(()async{
             SharedPreferences prefs = await SharedPreferences.getInstance();
            return 'JSESSIONID=${prefs.get('cookies')}';
          });
          return future.then((cookies){
            options.headers['Cookie'] = cookies;
            options.contentType = ContentType.parse(HttpConfig.contentType);
            return options;
          }).whenComplete(() => dio.unlock());
         
        },
        //响应拦截器
        onResponse: (Response response) {
          dio.lock();
          // if(response.realUri.toString().indexOf('login') > 0) {
          //   Future<dynamic> futrue = Future(()async {
          //     SharedPreferences prefs = await SharedPreferences.getInstance();
          //     return prefs;
          //   });
          //   return futrue.then((prefs){
          //     prefs.setString('cookies', getCookie(response));
          //   });
          // }
          
          if(response?.data != null) {
            if(response.data['code'] == 500) {
              Future.delayed(Duration(milliseconds: 10), (){
                Toast.toast(context, response.data['content']);
              });
            }
            if(response.data['code'] == 401) {
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=> false);
            }
          }
          dio.unlock();
          return response;
        },
        onError: (DioError e) {
          //当请求失败时做一些预处理
          print('dioError=$e');
          return e;
        }
      ));

      //请求类型
      if(method == 'get') {
        response = await dio.get(url);
      }else if(method == 'post') {
        response = await dio.post(url, data: dataMap);
      }
      //返回处理结果
      Map<String, dynamic> resCallBackMap = response.data;

      if(success != null) {
        success(resCallBackMap);
      }

    }on DioError catch(exception) {
      if(exception.response.statusCode == 500) {
        Toast.toast(context, exception.response.data['content']);
      }
      print('exception错误是 $exception');
      _handError(error, '数据请求错误：'+exception.toString());
    }
  }

  // 返回错误信息
  static  _handError(Function errorCallback,String errorMsg){
    if(errorCallback != null){
      errorCallback(errorMsg);
    }
  }
}

