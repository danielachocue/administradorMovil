import 'dart:convert' show json;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:my_app/trabajador.dart';
import 'package:my_app/cliente.dart';
import 'package:my_app/login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.green, Colors.greenAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  buttonSection(),
                ],
              ),
      ),
    );
  }

//////////////////////////////7
// Una función que convierte el body de la respuesta en un List<Photo>
  List<Data> convesor(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Data>((json) => Data.fromJson(json)).toList();
  }

///////////////////////////
Map data;
  Future<dynamic> signIn(String username, String password) async {
    String url = 'http://172.16.200.159:3000/api/login?username=' +
        username +
        "&password=" +
        password;
      
    print(url);
    final Response response = await Client().get(url);

    if (response.statusCode >= 400) {
      throw ('An error occurred: ' + response.body);
    }

    var objeto = convesor(response.body);

    print(objeto[0].id_usuario);
    int id=objeto[0].id_usuario;

    if (objeto[0].tipo == "trabajador") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TrabajadorPage(dato: id,)),
        
      );
      //print(TrabajadorPage(dato: Data(id_usuario:objeto[0].id_usuario),),);
    }
    
    else if(objeto[0].tipo=="cliente"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ClientePage()),
      );
    }
    //return json.decode(response.body);
  }

  Container buttonSection() {
    
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                  print('conecto');
                });
                signIn(emailController.text, passwordController.text);
              },
        elevation: 0.0,
        color: Colors.green,
        child: Text("Sign In", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nombredController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: "Email",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("Grid App",
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
}

class Data {
  int id_usuario;
  String nombre;
  String username;
  String tipo;

  Data({this.tipo, this.nombre, this.username, this.id_usuario});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        id_usuario: json['id_usuario'] as int,
        nombre: json['nombre'] as String,
        username: json['username'] as String,
        tipo: json['tipo'] as String);
  }
}

