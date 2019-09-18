import 'package:flutter/material.dart';
import 'package:flutter_crane_application/model/theme_model.dart';
import 'package:flutter_crane_application/pages/theme_setting_page.dart';
import 'package:provider/provider.dart';
import '../common/httputil.dart';
import 'package:flutter/cupertino.dart';
import '../config/theme_config.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  bool status = false;
  @override
  void initState() { 
    super.initState();
    _getTaskListInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _leading,
      ),
      drawer: _drawer,
      body: Container(
        child: Text('任务'),
      ),
    );
  }
  get _leading => Builder(
    builder: (context) => InkWell(
      child: Padding(
        child: CircleAvatar(
          radius: 10,
          backgroundImage: AssetImage('assets/images/user-header.jpeg',),
        ),
        padding: EdgeInsets.all(8),
      ),
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
    ),
  );
  get _drawer => Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Color(themeColorList[Provider.of<ThemeModel>(context).value]['primaryColor'])
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user-header.jpeg'),
                  ),
                ),
                Padding(
                  child: Text('用户名'),
                  padding: EdgeInsets.only(top: 10.0),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 40,
          child: Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(status? Icons.brightness_2:Icons.wb_sunny),
                    Padding(
                      child: Text(status? '黑夜模式' : '白天模式'),
                      padding: EdgeInsets.only(left: 10),
                    )
                  ],
                ),
                Switch (
                  value: status,
                  onChanged: (val) {
                    setState(() {
                      this.status = val; 
                    });
                  },
                  activeColor: Color(themeColorList[Provider.of<ThemeModel>(context).value]['primaryColor'])
                )
              ],
            ),
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          ),
        ),
        Divider(),
        listItem('主题', Icons.color_lens, () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return ThemeSettingPage();
          }));
        }),
        Divider(),
        listItem('设置', Icons.settings, () {}),
        Divider(),
        listItem('关于', Icons.error, () {}),
        Divider()
      ],
    ),
  );
  
  Widget listItem(String title, IconData icon, Function onTap) {
    return InkWell(
      child: Container(
        height: 40,
        child: Padding(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon),
                  Padding(
                    child: Text(title),
                    padding: EdgeInsets.only(left: 10),
                  )
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        ),
      ),
      onTap: onTap,
    );
  }
  _getTaskListInfo() {
    HttpUtil.get('/crane/crane_order/getCraneOrderTaskList',context, data: {'size':10, 'page': 1, 'orderStatus': 'history'},success: (res) {
      print(res);
    });
  }
}