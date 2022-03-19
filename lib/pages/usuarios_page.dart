import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsuariosPage extends StatefulWidget {

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);


  final usuarios = [
    Usuario(uid: '1', nombre: 'Francisco', email: 'test1@test.com', online:true),
    Usuario(uid: '2', nombre: 'Carlos', email: 'test2@test.com', online:true),
    Usuario(uid: '3', nombre: 'Moises', email: 'test3@test.com', online:false),
    Usuario(uid: '4', nombre: 'Jessica  ', email: 'test4@test.com', online:true),
    Usuario(uid: '4', nombre: 'Tamara', email: 'test5@test.com', online:false),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi nombre'),
         textTheme: TextTheme(),
        backgroundColor: Colors.blueGrey,
        elevation: 1,
        leading: IconButton(icon: Icon(Icons.exit_to_app),
        onPressed: () {},
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.check_circle),
             //child: Icon(Icons.offline_bolt),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400],),
          waterDropColor: Colors.blue[400],
        ),
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        child: _listViewUsuario(),

      ),
   );
  }

  _cargarUsuarios() async {
   await Future.delayed(Duration(milliseconds: 2000));

   _refreshController.refreshCompleted();
  }

  ListView _listViewUsuario() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]), 
      separatorBuilder: (_, i) => Divider(),
       itemCount: usuarios.length);
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey,
          child: Text(usuario.nombre.substring(0,2), style: TextStyle(color: Colors.white)),            
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.green[400] : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),),
      );
  }
}