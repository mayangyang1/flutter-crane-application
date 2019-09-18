import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

selectButton( List commonList, String selectValue, Function result) {
  return StatefulBuilder(
    builder: (BuildContext context, setState) {
      return Container(
        width: ScreenUtil().setWidth(200),
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 6),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Color(0xFFcccccc)
          ),
          borderRadius: BorderRadius.circular(5)
        ),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))
          ),
          value: selectValue,
          onChanged: (value){
            setState(() {
            selectValue = value; 
            });
            result(value);
          },
          items: commonList.map((item){
            return DropdownMenuItem(
              value: item['id'],
              child: Text(item['name']),
            );
          }).toList(),
        ),
      );
    },
  );
}
