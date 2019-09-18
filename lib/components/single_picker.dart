import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

singlePicker(BuildContext context, List<Map> singlePickerList, int _index, Function success) {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return CommonPicker(singlePickerList: singlePickerList, index:_index, success: success,);
    },
  );
}

class CommonPicker extends StatefulWidget {
  final List  singlePickerList;
  final Function success;
  final int  index;
  CommonPicker({Key key, this.singlePickerList, this.index, this.success}) : super(key: key);

  _CommonPickerState createState() => _CommonPickerState();
}

class _CommonPickerState extends State<CommonPicker> {
  FixedExtentScrollController siglePickerController = FixedExtentScrollController(); //单选框控制器
  int value = 0;
  @override
  void initState() {
    value = widget.index;
    Future.delayed(Duration(milliseconds: 10), (){
       siglePickerController.jumpToItem(widget.index);
    });
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(580),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: ScreenUtil().setSp(36),
          color: Color(0xFF454545)
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton (
                      child: Text('取消',style: TextStyle(fontSize: ScreenUtil().setSp(36)),),
                      onPressed: (){
                        Navigator.of(context).pop('取消');
                        Map res = {'key': 'cancel', 'value': value};
                        widget.success(res);
                      },
                    ),
                    FlatButton (
                      child: Text('确认',style: TextStyle(fontSize: ScreenUtil().setSp(36),color: Theme.of(context).primaryColor)),
                      onPressed: (){
                        Navigator.of(context).pop('确认');
                        Map res = {'key': 'confirm', 'value': value};
                        widget.success(res);
                      },
                    )
                  ],
                ),
              )
            ),
            Expanded(
              flex:5,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: commonPicker(widget.singlePickerList),
                  ),
                ],
              )
            )
          ],
        )
      )
    );
  }

  Widget commonPicker(List singlePickerList) {
    return CupertinoPicker(
      children: singlePickerList.length > 0
      ? singlePickerList.map((v){
          return Center(child: Text(v['key']),);
        }).toList()
      : [ Center(child: Text('暂无数据'),)],
      itemExtent: 38.0,
      backgroundColor: Colors.white,
      diameterRatio: 38.0,
      // offAxisFraction: 1.0,
      scrollController: siglePickerController,
      onSelectedItemChanged: (index){
        setState(() {
          value = index;
        });
      },
    );
  }
}

