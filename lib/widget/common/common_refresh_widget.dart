import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonRefreshListWidget extends StatelessWidget {
  final EasyRefreshController _controller;
  final List comList;
  final String title;
  final Function loadMore;
  final Function onRefresh;
  final Function commonItem;

  CommonRefreshListWidget( this._controller,this.comList, this.title, this.loadMore, this.onRefresh, this.commonItem);
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      topBouncing: true,
      bottomBouncing: true,
      controller: this._controller,
      child: this.comList.length > 0
      ?ListView.builder(
          itemCount: this.comList.length,
          itemBuilder: (BuildContext context, int index) {
          return this.commonItem(index,this.comList[index]);
        },
      )
      : Center(child: Padding(child: Text(this.title,style: TextStyle(fontSize: ScreenUtil().setSp(40)),),padding: EdgeInsets.only(top: 200))),
      onLoad: this.loadMore,
      onRefresh: this.onRefresh,
      footer: ClassicalFooter(
        bgColor: Colors.white,
        textColor: Colors.black26,
        noMoreText: '完成',
        loadText: '上拉加载',
        loadReadyText: '上拉加载',
        loadedText: '加载中',
        loadingText: '加载中',
        showInfo: false
      ),
      header: ClassicalHeader(
        bgColor: Colors.white,
        textColor: Colors.black26,
        refreshReadyText: '下拉刷新',
        refreshedText: '刷新完成',
        showInfo: false
        
      ),
    );
  }
}
