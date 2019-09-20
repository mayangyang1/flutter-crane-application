import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/httputil.dart';
import 'package:flutter/cupertino.dart';
import '../config/theme_config.dart';
import '../widget/task_list_page_widget.dart';
import '../widget/common/common_refresh_widget.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  EasyRefreshController _controller = EasyRefreshController();
  bool status = false;
  int page = 1;
  String logisticsStatus = "todo,doing,finish";
  List logisticsList = [];
  @override
  void initState() { 
    super.initState();
    _getTaskListInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leading(),
        title: Text('任务列表'),
        centerTitle: true,
      ),
      drawer: drawer(context, themeColorList, status),
      body: CommonRefreshListWidget(_controller,logisticsList, '暂无订单', _loadMore, _onRefresh, itemCardWidget)
    );
  }
  Future  _loadMore()async{
    _getTaskListInfo();
  }
  Future _onRefresh()async{
    page =1;
    logisticsList = [];
    _getTaskListInfo();
  }
  _getTaskListInfo() async{
    Map<String, dynamic> params = {};
    params["page"] = page;
    params["size"] = 10;
    params["logisticsStatus"] = logisticsStatus;
    HttpUtil.get('/logistics/logistics/list',context, data: params,success: (res) {
      if(res["code"] == 200 && res['content'].length > 0) {
        page++;
        setState(() {
          logisticsList.addAll(res['content']);
        });
        print(res);
      }
    });
  }

  Widget itemCardWidget(int index, Map item){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(10.0),
        // height: 200,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('20190917D002332',style: TextStyle(
                    fontSize: ScreenUtil().setSp(40)
                  ),),
                  Text('执行中',style: TextStyle(
                    color: Color(0xFF888888)
                  ),)
                ],
              ),
            ),
            Padding(
              child: Text('煤炭'),
              padding: EdgeInsets.only(bottom: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('发货单位',style: TextStyle(
                  color: Color(0xFF787878)
                ),),
                SizedBox(width: 10,),
                Text('收货单位',style: TextStyle(
                  color: Color(0xFF787878)
                ),)
              ],
            )
          ],
        )
      ),
      onTap: (){
        
      }
    );
  }
}

