import 'package:flutter/material.dart';
import 'package:flutter_crane_application/model/theme_model.dart';
import '../config/theme_config.dart';
import 'package:provider/provider.dart';
class ThemeSettingPage extends StatefulWidget {
  @override
  _ThemeSettingPageState createState() => _ThemeSettingPageState();
}

class _ThemeSettingPageState extends State<ThemeSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('主题'),),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Wrap(
          spacing: 20.0,
          runSpacing: 10.0,
          alignment: WrapAlignment.start,
          children: themeColorList.length > 0
          ? themeColorList.map((item){
            return InkWell(
              child: Container(
                width:46,
                height:46,
                color: Color(item['primaryColor']),
                child: Text(''),
              ),
              onTap: (){
                Provider.of<ThemeModel>(context).changeThemeColor(item['index']);
              },
            );
          }).toList()
          : Text('')
        )
      ),
    );
  }
}