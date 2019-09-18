import 'package:flutter/material.dart';
import 'package:flutter_crane_application/pages/login_page.dart';
import './pages/splash_screen.dart';
import 'package:provider/provider.dart';
import './model/theme_model.dart';
import './config/theme_config.dart';

void main(){
  final themeColor = ThemeModel();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeColor)
      ],
      child: MyApp(),
    )
  );

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primaryColor: Color(themeColorList[Provider.of<ThemeModel>(context).value]["primaryColor"]),
        iconTheme: IconThemeData(
          color: Color(themeColorList[Provider.of<ThemeModel>(context).value]["primaryColor"])
        ),
        // accentColor: Color(0xFFF2F2F2),
        // primaryTextTheme: TextTheme(
        //   display1: TextStyle(color: Colors.red)
        // ),
        // scaffoldBackgroundColor: Color(0xFFCCCCCC)
      ),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => LoginPage(),
      },
      home: SplashScreen(),
    );
  }
}
