import 'package:flutter/material.dart';
import '../widget/login_page_widget.dart';
import '../components/toast.dart';
import '../common/httputil.dart';
import './index_page.dart';

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
      body: loginPageWidget(phoneController, passwordController, context, (){})
    );
  }
  _login(){
    if(phoneController.text == '') {
      return Toast.toast(context, '请输入账号');
    }
    if(passwordController.text == '') {
      return Toast.toast(context, '请输入密码');
    }
    Map<String, dynamic> params = {};
    params["loginAccount"] = phoneController.text.trim();
    params['password'] = passwordController.text.trim();
    HttpUtil.post('/account/wxEmployeeLogin', context,data: params, success: (res){
      if(res['code'] == 200) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return IndexPage();
        }));
      }
    });

  }
}