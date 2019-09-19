import 'package:flutter/material.dart';
import '../widget/common/input_widget.dart';
import '../widget/common/common_button_widget.dart';

loginPageWidget(TextEditingController phoneController, TextEditingController passwordController, BuildContext context,Function onTap) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 40.0),),
        Image.asset('assets/images/logo.png'),
        Padding(
          child: InputWidget(phoneController, '请输入账号', (res){},imgUrl: 'assets/images/users.png',),
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        ),
        Padding(
          child: InputWidget(passwordController, '请输入密码', (res){},imgUrl: 'assets/images/password.png',obscureText: true,),
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
        ),
        CommonButtonWidget(context, '登录', onTap)
      ],
    ),
  );
}