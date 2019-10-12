import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crane_application/common/httputil.dart';
import 'package:flutter_crane_application/components/toast.dart';
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
  TimerUtil oldTimer;
  TimerUtil newTimer;
  String oldText = '获取验证码';
  String newText = '获取验证码';
  

  @override
  void initState() { 
    super.initState();
    oldPhoneController.text = '19090098698';
    _getOldPhoneCountDown();
    _getNewPhoneCountDown();
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
            CommonBarWidget('验  证  码:', InputWidget(oldCodeController, '请输入验证码', (res){},border:false,inputType: 'number',),MiniButtonWidget(context, oldText, oldTimer.isActive()? false : true, _getoldPhoneVeifyCode,fontColor: oldTimer.isActive()?0xFFCCCCCC : null,)),
            SizedBox(height: 10,),
            CommonBarWidget('新手机号:', InputWidget(newPhoneController, '请输入新手机号', (res){},border:false,inputType: 'number'),Text('')),
            CommonBarWidget('验  证  码:', InputWidget(newCodeController, '请输入验证码', (res){},border:false,inputType: 'number'),MiniButtonWidget(context, newText, newTimer.isActive()? false : true, _getNewPhoneVeifyCode, fontColor: newTimer.isActive()? 0xFFCCCCCC : null,)),
            SizedBox(height: ScreenUtil().setHeight(100),),
            CommonButtonWidget(context, '确认', (){})
          ],
        ),
      ),
    );
  }
  _getOldPhoneCountDown() {//旧手机号验证码倒计时
    oldTimer = TimerUtil(mInterval: 1000, mTotalTime: 60*1000);
    oldTimer.setOnTimerTickCallback((int tick) {
      double _tick = tick/1000;
      if(_tick.toInt() == 0) {
        oldTimer.setTotalTime(60*1000);
        setState(() {
         oldText = '获取验证码'; 
        });
      }else{
        setState(() {
          oldText = '重新获取(${_tick.toInt().toString()})'; 
        });
      }
      
      
    });
  }
  _getNewPhoneCountDown() {//新手机号验证码倒计时
    newTimer = TimerUtil(mInterval: 1000, mTotalTime: 60*1000);
    newTimer.setOnTimerTickCallback((int tick) {
      double _tick = tick/1000;
      if(_tick.toInt() == 0) {
        newTimer.setTotalTime(60*1000);
        setState(() {
         newText = '获取验证码'; 
        });
      }else{
        setState(() {
          newText = '重新获取(${_tick.toInt().toString()})'; 
        });
      }
      
      
    });
  }
  _getoldPhoneVeifyCode() {
    String phone = oldPhoneController.text.trim();
    bool isPhoneNumber = RegexUtil.isMobileSimple(phone);
    if(!isPhoneNumber){
      return Toast.toast(context, '手机号码不正确'); 
    }
    if (isPhoneNumber && !oldTimer.isActive()) {
      _getVerifyCodeServer({'mobilePhone': phone},(res){
        if(res['code'] == 200) {
          oldTimer.startCountDown();
        }
      });
    } 
  }
  _getNewPhoneVeifyCode() {
    String phone = newPhoneController.text.trim();
    bool isPhoneNumber = RegexUtil.isMobileSimple(phone);
    if(!isPhoneNumber) {
      return Toast.toast(context, '手机号码不正确');
    }
    if (isPhoneNumber && !newTimer.isActive()) {
      _validatePhoneServer(phone, (res){
        if(res['code'] == 200) {
          _getVerifyCodeServer({'mobilePhone': phone}, (result){
            if(result['code'] == 200) {
              newTimer.startCountDown();
            }else{
              return Toast.toast(context, result['content']);
            }
          });
        }else{
          return Toast.toast(context, res['content']);
        }
      });
      
    }
  }
  _getVerifyCodeServer(Map<String, dynamic> data, Function success) {
    HttpUtil.post('/account/account/send/verify_code', context, data:data, success: success);
  }
  _validatePhoneServer(String phone,Function success) {//校验手机号是否存在
    HttpUtil.post('/account/account/$phone/validate', context, success: success);
  }
  @override
  void dispose() { 
    
    super.dispose();
    if(oldTimer != null) oldTimer.cancel();
    if(newTimer != null) newTimer.cancel();
  }
}