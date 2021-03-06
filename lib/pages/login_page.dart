import 'package:flutter/material.dart';
import '../widget/login_page_widget.dart';
import '../components/toast.dart';
import './index_page.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import '../config/base_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/util.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('登录')),
      body: loginPageWidget(phoneController, passwordController, context, _login)
    );
  }
  _login()async{
    if(phoneController.text == '') {
      return Toast.toast(context, '请输入账号');
    }
    if(passwordController.text == '') {
      return Toast.toast(context, '请输入密码');
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> params ={};
    params["account"] = phoneController.text.trim();
    params["password"] = passwordController.text.trim();

    try {
      Response response;
      Dio dio = new Dio();
      dio.options.contentType = ContentType.parse(HttpConfig.contentType);
      response = await dio.post(HttpConfig.url + '/account/login',data: params);
        if(response.data['code'] == 200) {
          String cookies = Utils.getCookie(response);
          prefs.setString('cookies', cookies);
          Toast.toast(context, '登录成功');
          Future.delayed(Duration(milliseconds: 1000),() {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
              return IndexPage();
            }), (route)=> route == null);
          });
        }else{
          Toast.toast(context, response.data['content']);
        }
    }on DioError catch(e) {
      if(e.response.statusCode == 500) {
        Toast.toast(context, e.response.data['content']);
      }
      print(e);
    }
    
  }
}