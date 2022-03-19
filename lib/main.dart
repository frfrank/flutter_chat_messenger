import 'package:flutter/material.dart';

import 'package:chat/routes/routes.dart';
import 'package:flutter/services.dart';

void main() {
runApp(MyApp());
SystemChrome.setSystemUIOverlayStyle(
  SystemUiOverlayStyle(
    statusBarColor: Colors.white,    
    systemNavigationBarColor: Colors.white));
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    
      title: 'Chat App',
      initialRoute: 'chat',
      routes: appRoutes,
    );
  }
}