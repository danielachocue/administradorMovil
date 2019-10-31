import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/semantics.dart';
import 'package:my_app/login.dart';
import 'package:my_app/crearusuario.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' ;


class TrabajadorPage extends StatefulWidget{
 int  dato;  

TrabajadorPage({Key key, @required this.dato}) : super(key: key);


  @override
  _TrabajadorPage createState()=>new _TrabajadorPage(dato);
}


class _TrabajadorPage extends State<TrabajadorPage>  {

int dato;

_TrabajadorPage(this.dato);

Map data;
List userData;

  SharedPreferences sharedPreferences;
  
getUsers() async  {

  print(this.dato);
    String id=this.dato.toString();
    String url = 'http://172.16.200.159:3000/api/trabajadorentidades?id_usuario=' + id;
    final Response response = await Client().get(url);
    print(url);
    debugPrint(response.body);
  }
  @override
  void initState() {
    super.initState();
    getUsers();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Trabajador", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:Text("$index"),
              ),
                Text("${userData[index]["id_entidad" "entidad" "cantidad"]}"),
            ],),
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Colors.green, Colors.greenAccent])),
                child: Container(
                  child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Grid App',
                          style:
                              TextStyle(color: Colors.white, fontSize: 40.0)),
                    )
                  ]),
                )),
            CreateListTitle(
                Icons.person,
                'Crear Usuario',
                () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      )
                    }),
            CreateListTitle(Icons.notifications, 'Proyectos', () => {}),
            CreateListTitle(Icons.money_off, 'Manejo de Presupuesto', () => {}),
            CreateListTitle(
                Icons.lock,
                'Cerrar Sesión',
                () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      )
                    }),
          ],
        ),
      ),
    );
  }
  

}


class CreateListTitle extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CreateListTitle(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
          splashColor: Colors.greenAccent,
          onTap: onTap,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(text, style: TextStyle(fontSize: 16.0)),
                    )
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
