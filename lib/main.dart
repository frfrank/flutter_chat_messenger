import 'package:chat/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: ( _ ) => AuthService())
          ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
      
        title: 'Chat App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}