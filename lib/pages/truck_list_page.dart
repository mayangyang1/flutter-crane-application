import 'package:flutter/material.dart';

class TruckListPage extends StatefulWidget {
  @override
  _TruckListPageState createState() => _TruckListPageState();
}

class _TruckListPageState extends State<TruckListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('任务'),),
      body: Container(
        child: Text('车辆'),
      ),
    );
  }
}