import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './module.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      title: Text('任务')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('司机')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_shipping),
      title: Text('车辆')
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.person_outline),
    //   title: Text('我')
    // ),
  ];

  final List<Widget> tabBodies = [
    TaskListPage(),
    DriverListPage(),
    TruckListPage(),
    // UserPage()
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
           currentIndex = index; 
          });
        },
      ),
      
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      )
    );
  }
}