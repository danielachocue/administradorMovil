import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:my_app/trabajador.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading = false;
  //final GlobalKey<FormState> _fromKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Crear Usuario", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  textSection(),
                  buttonSection(),
                ],
              ),
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
          onPressed: () async {
                _makePostRequest(nombreController.text,emailController.text,passwordController.text,idtipoController.text);
                      },
                      elevation: 0.2,
                    color: Colors.green,
                    child: Text("Sign Up", style: TextStyle(color: Colors.white70)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                );
              }
            
              final TextEditingController nombreController = new TextEditingController();
              final TextEditingController emailController = new TextEditingController();
              final TextEditingController passwordController = new TextEditingController();
              final TextEditingController idtipoController = new TextEditingController();
              final TextEditingController idusarioController = new TextEditingController();
              int gender;
              String groupValue = "Cliente";
              bool loading = false;
            
              Container textSection() {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: nombreController,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(Icons.person, color: Colors.green),
                          hintText: "Nombre",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black45)),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        controller: emailController,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(Icons.email, color: Colors.green),
                          hintText: "Username",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black45)),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return "the name field cannnot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.0),
                      SizedBox(height: 15.0),
                      TextFormField(
                        controller: idtipoController,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(Icons.person_outline, color: Colors.green),
                          hintText: "Tipodeusuario",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black45)),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return "the name field cannnot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        controller: passwordController,
                        cursorColor: Colors.white,
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock, color: Colors.green),
                          hintText: "Password",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return "password fiel cannot be empty";
                          }else if(value.length<5){
                            return "The password to be at least 5 charaters long";
                          }else if(passwordController.text!=value){
                            return "The password do not match";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                );
              }
            
              valueChanged(e) {
                setState(() {
                  if (e == "Trabajador") {
                    groupValue = e;
                    gender=1;
                  } else if (e == "Cliente") {
                    groupValue = e;
                    gender=2;
                  } else if (e == "Inversor") {
                    groupValue = e;
                    gender=3;
                  }
                });
              }
}
_makePostRequest(String name, String email, String password, String tipo) async {
  // set up POST request arguments
  
  var url = 'http://172.16.200.159:3000/api/usser';
   
 /* Map data={
    'name':nombre,
    'email':username,
    'password':password,
    'tipo':id_tipo
  };*/
  var cuerpo = {"name": name, "email": email,"password": password,"tipo": tipo};
  // make POST request

  var conversion=json.encode(cuerpo);
 
  Response response = await post(url, headers: {"Content-type": "application/json"}, body: conversion);
  // check the status code for the result
  //int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  String body = response.body;
  print(body);
  // {
  //   "title": "Hello",
  //   "body": "body text",
  //   "userId": 1,
  //   "id": 101
  // }
}