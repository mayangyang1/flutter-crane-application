import 'package:flutter/material.dart';
import 'package:flutter_crane_application/widget/common/common_button_widget.dart';
import 'package:flutter_crane_application/widget/common/commonbar_widget.dart';
import 'package:flutter_crane_application/widget/common/input_widget.dart';
import 'package:flutter_crane_application/widget/common/mini_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ChangePhonePage extends StatefulWidget {
  @override
  _ChangePhonePageState createState() => _ChangePhonePageState();
}

class _ChangePhonePageState extends State<ChangePhonePage> {
  TextEditingController oldPhoneController = TextEditingController();
  TextEditingController newPhoneController = TextEditingController();
  TextEditingController oldCodeController = TextEditingController();
  TextEditingController newCodeController = TextEditingController();

  @override
  void initState() { 
    super.initState();
    oldPhoneController.text = '15755379861';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(title: Text('修改手机号'),),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CommonBarWidget('原手机号:', InputWidget(oldPhoneController, '', (res){},border:false,enabled: false,),Text('')),
            CommonBarWidget('验  证  码:', InputWidget(oldCodeController, '请输入验证码', (res){},border:false,inputType: 'number',),MiniButtonWidget(context, '获取验证码', true, (){})),
            SizedBox(height: 10,),
            CommonBarWidget('新手机号:', InputWidget(newPhoneController, '请输入新手机号', (res){},border:false,inputType: 'number'),Text('')),
            CommonBarWidget('验  证  码:', InputWidget(newCodeController, '请输入验证码', (res){},border:false,inputType: 'number'),MiniButtonWidget(context, '获取验证码', true, (){})),
            SizedBox(height: ScreenUtil().setHeight(100),),
            CommonButtonWidget(context, '确认', (){})
          ],
        ),
      ),
    );
  }
}