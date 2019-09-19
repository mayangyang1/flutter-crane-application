import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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
          border: Border(bottom: BorderSide(width: 1,color: Color(0XFFCCCCCC)),top: BorderSide(width: 1,color: Color(0xFFCCCCCC))),
          color: Color(0xFFFFFFFF)
        ),
        child: Text('777')
      ),
      onTap: (){
        
      }
    );
  }
}

