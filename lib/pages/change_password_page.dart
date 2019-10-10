import 'package:flutter/material.dart';
import 'package:flutter_crane_application/widget/common/common_button_widget.dart';
import 'package:flutter_crane_application/widget/common/commonbar_widget.dart';
import 'package:flutter_crane_application/widget/common/input_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController surePasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(title: Text('修改登录密码'),),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CommonBarWidget('原  密  码:', InputWidget(oldPasswordController, '请输入原密码', (res){},border:false,),Text('')),
            SizedBox(height: 10),
            CommonBarWidget('新  密  码:', InputWidget(newPasswordController, '请输入新密码', (res){},border:false,),Text('')),
            CommonBarWidget('确认密码:', InputWidget(surePasswordController, '请确认新密码', (res){},border:false,),Text('')),
            SizedBox(height:ScreenUtil().setHeight(100)),
            CommonButtonWidget(context, '确认', (){})
          ],
           
        ),
      ),
    );
  }
}