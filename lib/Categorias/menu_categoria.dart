

import 'package:cocreacion/Categorias/belleza.dart';
import 'package:cocreacion/Categorias/cuidado_personal.dart';
import 'package:cocreacion/Categorias/iverus.dart';
import 'package:cocreacion/Categorias/moda.dart';
import 'package:cocreacion/Categorias/test_belleza.dart';
import 'package:cocreacion/Categorias/test_cp.dart';
import 'package:cocreacion/Categorias/test_moda.dart';

import 'package:flutter/material.dart';

import 'dart:io';

class MenuCategoriaPage extends StatefulWidget {
  @override
  _MenuCategoriaPageState createState() => _MenuCategoriaPageState();
}

class _MenuCategoriaPageState extends State<MenuCategoriaPage> {
  File _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MENU'),
      ),
      body: Builder(
        builder: (context) =>  Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Color(0xff476cfb),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Iverus()),
                      );
                      print('IVERUZ');
                    },
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'IVERUZ',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  RaisedButton(
                    color: Color(0xff476cfb),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Moda()),
                      );
                      print('MODA');
                    },

                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'MODA',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),

                  RaisedButton(
                    color: Color(0xff476cfb),
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Belleza()),
                      );
                      print('BELLEZA');
                    },

                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'BELLEZA',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  RaisedButton(
                    color: Color(0xff476cfb),
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Cpersonal()),
                      );
                      print('CUIDADO PERSONAL');
                    },

                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'CP',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),


                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}