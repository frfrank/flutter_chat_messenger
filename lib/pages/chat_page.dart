import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget  {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

List<ChatMessage> _messages = [
  


];

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Column(children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text(
              'FP',
              style: TextStyle(fontSize: 10),
            ),
            maxRadius: 14,
          ),
          SizedBox(height: 3),
          Text(
            'Francisco Picado',
            style: TextStyle(fontSize: 12),
          )
        ]),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Flexible(
              child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _messages.length,
            itemBuilder: (_, i) => _messages[i],
            reverse: true,
          )),
          Divider(height: 1),

          //Todo caja de texto
          Container(
            color: Colors.white,
            height: 100,
            child: _inputChat(),
          )
        ],
      )),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(children: <Widget>[
        Flexible(
            child: TextField(
          controller: _textController,
          onSubmitted: _handleSubmit,
          onChanged: (String texto) {
           setState(() {
             if(texto.trim().length> 0){
               _estaEscribiendo = true;
             }
             else{
               _estaEscribiendo = false;
             }
           });
          },
          decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
          focusNode: _focusNode,
        )),

        //Boton Enviar
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          child: Platform.isIOS ? 
          CupertinoButton(child: Text('Enviar'),
           onPressed: _estaEscribiendo ? () => _handleSubmit(_textController.text.trim())
                 : null,)
           : Container(
             margin: EdgeInsets.symmetric(horizontal: 4.0),
             child: IconTheme(
               data: IconThemeData(color: Colors.white12),
                child: CircleAvatar(
                  backgroundColor: _estaEscribiendo ? Colors.blue[100] : Colors.grey,
                    child: IconButton(                   
                   highlightColor: Colors.transparent,
                   splashColor: Colors.transparent,
                   icon:Icon(Icons.send),
                   onPressed: _estaEscribiendo ? () => _handleSubmit(_textController.text.trim())
                   : null,
                   ),
                ),
             ),
             )
        )
      ]),
    ));
  }
  _handleSubmit(String text){
    if(text.length == 0) return;
    print(text);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: '123', 
      texto:text,
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 400)),
      );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }
}
