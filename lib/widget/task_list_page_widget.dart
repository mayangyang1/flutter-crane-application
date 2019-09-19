import 'package:flutter/material.dart';
import '../pages/theme_setting_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_crane_application/model/theme_model.dart';

//leading头像
Widget leading() {
  return Builder(
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
}
//抽屉
Widget drawer(BuildContext context, List themeColorList, bool status) {
  return Drawer(
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
                StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return Switch (
                      value: status,
                      onChanged: (val) {
                        setState(() {
                          status = val; 
                        });
                      },
                      activeColor: Color(themeColorList[Provider.of<ThemeModel>(context).value]['primaryColor'])
                    );
                  },
                ),
                
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
}
//抽屉项
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