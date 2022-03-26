import 'package:chat/pages/login_page.dart';
import 'package:chat/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:chat/pages/usuarios_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: chekLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future chekLoginState(BuildContext context) async {
    final authServide = Provider.of<AuthService>(context, listen: false);

    final autenticando = await authServide.isLoggeIn();
    if (autenticando) {
      //TODO: conectar al socket server
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (__, ___, ____) => UsuariosPage(),
              transitionDuration: Duration(milliseconds: 0)));
    } else
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (__, ___, ____) => LoginPage(),
              transitionDuration: Duration(milliseconds: 0)));
  }
}
