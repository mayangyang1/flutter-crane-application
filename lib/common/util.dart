import 'package:shared_preferences/shared_preferences.dart';

getCookie (res){
  String cookies;
  var  cookiestr = res.headers['set-cookie'].join(';');
  List  cookiesarr = cookiestr.split(';');
  print('cookiestr');
  print(cookiesarr);
  cookiesarr.forEach((item){
    if(item.indexOf('JSESSIONID') != -1){
      var itemar = item.split('=');
      cookies = itemar[itemar.length - 1];
    }
  });
  return cookies;
}