import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioWidget extends StatelessWidget {
  final List<Map<String, dynamic>> radioList;
  final int indexValue;
  final Function result;

  RadioWidget(this.radioList, this.indexValue, this.result);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: radioList.map((item){
          return raioItemWidget(indexValue, item['index'], item['title'],result);
        }).toList()
      ),
    );
  }
}

Widget raioItemWidget(int groupValue, int index, String title, Function result) {
  return StatefulBuilder(
    builder: (BuildContext context, setState) {
      return Container(
        child: Row(
          children: <Widget>[
            Radio(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              groupValue: groupValue,
              value: index,
              onChanged: (indexs){
                setState(() {
                groupValue = indexs; 
                });
                result(indexs);
              },
            ),
            Text(title,style: TextStyle(
              fontSize: ScreenUtil().setSp(28)
            ),)
          ],
        ),
      );
    },
  );
}