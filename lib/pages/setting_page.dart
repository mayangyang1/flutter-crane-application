import 'package:flutter/material.dart';
import 'package:flutter_crane_application/pages/change_password_page.dart';
import 'package:flutter_crane_application/pages/change_phone_page.dart';
import 'package:flutter_crane_application/widget/common/common_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/common/panelbar_widget.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(title: Text('设置')),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height:5 ),
              PanelBarWidget('修改登录账号', '', (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return ChangePhonePage();
                }));
              },),
              SizedBox(height:5 ),
              PanelBarWidget('修改登录密码', '', (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return ChangePasswordPage();
                }));
              }),
              SizedBox(
                height: ScreenUtil().setHeight(400),
              ),
              CommonButtonWidget(context, '退出', (){})
            ],
          ),
          color: Color(0xFFF2F2F2)
        ),
      ),
    );
  }

}