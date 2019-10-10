import 'package:flutter/material.dart';
import 'package:flutter_crane_application/pages/login_page.dart';
import './pages/splash_screen.dart';
import 'package:provider/provider.dart';
import './model/theme_model.dart';
import './config/theme_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  final themeColor = ThemeModel();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final int themIndex = prefs.getInt('themeColorIndex')??0;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeColor)
      ],
      child: MyApp(themIndex),
    )
  );

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final int themIndex;
  MyApp(this.themIndex);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
    
        primaryColor: Color(themeColorList[Provider.of<ThemeModel>(context).value != 0? Provider.of<ThemeModel>(context).value : this.themIndex]["primaryColor"]),
        iconTheme: IconThemeData(
          color: Color(themeColorList[Provider.of<ThemeModel>(context).value != 0? Provider.of<ThemeModel>(context).value : this.themIndex]["primaryColor"])
        ),
      ),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => LoginPage(),
      },
      home: SplashScreen(),
    );
  }
}
