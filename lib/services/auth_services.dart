import 'dart:convert';

import 'package:chat/global/enviroment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  //Getters del token de forma estática
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<String> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future login<bool>(String email, String password) async {
    this.autenticando = true;
    final data = {'email': email, 'password': password};

    final res = await http.post(Uri.parse('${Enviroment.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      this.usuario = loginResponse.usuario;
      this._guardarToken(loginResponse.token);
      return true;
    } else
      return false;
  }

  Future register(String name, String email, String password) async {
    this.autenticando = true;
    final data = {'nombre': name, 'email': email, 'password': password};

    final res = await http.post(Uri.parse('${Enviroment.apiUrl}/login/new'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      this.usuario = loginResponse.usuario;
      this._guardarToken(loginResponse.token);
      return true;
    } else {
      final resBody = jsonDecode(res.body);

      return resBody['msg'];
    }
  }

  Future isLoggeIn() async {
    final token = await this._storage.read(key: 'token');

    final res = await http.get(Uri.parse('${Enviroment.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': token});

    this.autenticando = false;
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      this.usuario = loginResponse.usuario;
      this._guardarToken(loginResponse.token);
      return true;
    } else
      this.logout();
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    return await _storage.delete(key: 'token');
  }
}
