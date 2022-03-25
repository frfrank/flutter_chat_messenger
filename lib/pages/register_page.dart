import 'package:chat/helper/mostrar_alerta.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:provider/provider.dart';



class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Logo( titulo: 'Registro' ),

                _Form(),

                Labels( 
                  ruta: 'login',
                  titulo: '¿Ya tienes una cuenta?',
                  subTitulo: 'Ingresa ahora!',
                ),

                Text('Términos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w200 ),)

              ],
            ),
          ),
        ),
      )
   );
  }
}



class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final nameCtrl  = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl  = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
       child: Column(
         children: <Widget>[
           
           CustomInput(
             icon: Icons.perm_identity,
             placeholder: 'Nombre',
             keyboardType: TextInputType.text, 
             textController: nameCtrl,
           ),

           CustomInput(
             icon: Icons.mail_outline,
             placeholder: 'Correo',
             keyboardType: TextInputType.emailAddress, 
             textController: emailCtrl,
           ),

           CustomInput(
             icon: Icons.lock_outline,
             placeholder: 'Contraseña',
             textController: passCtrl,
             isPassword: true,
           ),
           

           BotonAzul(
             text: 'Ingrese',
             onPressed: authService.autenticando ? null : () async{          
              final registerOk = 
               await authService.register(
                 nameCtrl.text.trim(), 
                 emailCtrl.text.trim(),
                  passCtrl.text.trim());

              if(registerOk){
                mostrarAlerta(context, 'Registro', 'Se registro correctamente');
              }else mostrarAlerta(context, 'Registro', 'Ocurrio un error');
             },
           )



         ],
       ),
    );
  }
}
