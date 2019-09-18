import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MiniButtonWidget extends StatelessWidget {
  final BuildContext context;
  final String title;
  final bool isMainColor;
  final Function change;

  MiniButtonWidget(this.context, this.title, this.isMainColor, this.change);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: InkWell(
        child: Container(
          width: ScreenUtil().setWidth(200),
          height: ScreenUtil().setHeight(80),
          decoration: BoxDecoration(
            color: isMainColor? Theme.of(context).primaryColor :Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(width:1, color: isMainColor? Theme.of(context).primaryColor : Color(0xFFCCCCCC)),
            boxShadow: [
              BoxShadow(
                offset: Offset(2, 2),
                color: Color(0xFFCCCCCC)
              )
            ]
          ),
          child: Center(
            child: Text(title, style: TextStyle(color: isMainColor? Color(0xFFFFFFFF) :Color(0xFF454545)),),
          ),
        ),
        onTap: change,
      ),
      padding: EdgeInsets.only(left:10),
    );
  }
}