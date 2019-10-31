import 'package:flutter/material.dart';
//import 'package:flutter/semantics.dart';
import 'package:my_app/login.dart';
import 'package:my_app/crearusuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientePage extends StatelessWidget {
  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Cliente", style: TextStyle(color: Colors.white)),
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
      body: Container(
        child: ListView(
          children: <Widget>[
             CreateListTitle(Icons.home,'Sucursales',()=>{}), 
             CreateListTitle(Icons.home,'Sucursales',()=>{}), 
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors:<Color>[
                  Colors.green,
                  Colors.greenAccent
                ])
              ),
              child:Container(
                child: Column(
                  children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),child: Text('Grid App',style:TextStyle(color:Colors.white, fontSize: 40.0 )),)
                  ]),
              )),
           CreateListTitle(Icons.person,'Proyectos',()=>{}),
            CreateListTitle(Icons.notifications,'Avance de Proyectos',()=>{}),
            CreateListTitle(Icons.money_off, 'Presupuesto', ()=>{}),
            CreateListTitle(Icons.lock,'Cerrar Sesión',()=>{Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),)}),
          ],
        ),
      ),
    );
  }
  @override
  State<StatefulWidget> createState() {
    
    return null;
  }
}
class CreateListTitle extends StatelessWidget{

IconData icon;
String text;
Function onTap;

CreateListTitle(this.icon,this.text,this.onTap);

  @override 
  Widget build (BuildContext context){
    return Padding(padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400))
        ),
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
                   child: Text(text, style: TextStyle(
                     fontSize: 16.0)),
                 )
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ) ,
        ),
      ),
    );
  }
}