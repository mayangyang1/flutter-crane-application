import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CommonBarWidget extends StatelessWidget {
  final String leftTitle;
  final Widget centerWidget;
  final Widget rightWidget;
  final double sizeWidth;
  CommonBarWidget(this.leftTitle, this.centerWidget, this.rightWidget, {this.sizeWidth}); 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10,right:10),
      decoration: BoxDecoration(
        border:Border(bottom: BorderSide(width: 1,color: Color(0xFFF2F2F2))),
        color: Colors.white,
      ),
      height: ScreenUtil().setHeight(110),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(child: SizedBox(
            width: ScreenUtil().setWidth(sizeWidth??160),
            child: Text(leftTitle??'',style: TextStyle(fontSize: ScreenUtil().setSp(32)),),
          ),padding: EdgeInsets.only(right: 6),),
          Expanded(child: centerWidget),
          rightWidget
        ],
      ),
    );
  }
}