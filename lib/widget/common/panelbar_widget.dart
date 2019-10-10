import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PanelBarWidget extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;
  final Function onTap;
  final double leftFontSize;
  final double rightFontSize;
  final int leftColor;
  final int rightColor;
  PanelBarWidget(this.leftTitle, this.rightTitle, this.onTap,{this.leftFontSize,this.rightFontSize,this.leftColor, this.rightColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: ScreenUtil().setHeight(110),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Color(0xFFF2F2F2))),
          color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(leftTitle??'',style: TextStyle(fontSize: ScreenUtil().setSp(leftFontSize??32),color: Color(leftColor??0xFF454545)),),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    child: Text(rightTitle??'',style: TextStyle(fontSize: ScreenUtil().setSp(leftFontSize??28),color: Color(rightColor??0xFF454545)),),
                    padding: EdgeInsets.only(right: 5,),
                  ),
                  Icon(Icons.arrow_forward_ios,size:20)
                ],
              ),
            )
            
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}