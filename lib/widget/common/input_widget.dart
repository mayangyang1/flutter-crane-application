import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function change;
  final String imgUrl;
  final bool obscureText;
  final bool enabled;
  final String inputType;
  final bool border;
  final String align;

  InputWidget(this.controller, this.hintText, this.change,{this.imgUrl, this.obscureText, this.enabled, this.inputType, this.border, this.align});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.0),
      decoration: BoxDecoration(
        border: border != null && !border? Border.all(color: Colors.transparent): Border.all(width: 1.0, color: Color(0xFFCCCCCC)),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: <Widget>[
          imgUrl != null
          ? Image.asset(imgUrl,width: ScreenUtil().setWidth(60),)
          : Container(child: null,),
          imgUrl != null
          ? Padding(child: null,padding: EdgeInsets.only(left: 10),)
          : Container(child: null,),
          Expanded(
            child: TextField(
              controller: controller,
              textAlign: align != null && align == 'center'? TextAlign.center : TextAlign.start,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide(color: Colors.transparent)
                ),
                disabledBorder: InputBorder.none,
                enabledBorder:InputBorder.none,
                focusedBorder:InputBorder.none
              ),
              cursorColor: Colors.black,
              obscureText: obscureText !=null? obscureText : false,
              enabled: enabled !=null? enabled : true,
              keyboardType: inputType != null && inputType == 'number'? TextInputType.number : TextInputType.text,
              onChanged: (text){
                return change(text);
              },
            ),
          )
        ],
      ),
    );
  }
}