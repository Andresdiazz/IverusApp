import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:cocreacion/Ideas/ui/screens/home_page.dart';
import 'package:flutter/material.dart';

class Evaluar extends StatefulWidget {
  final CategoryItem documentData;
  final CategoriesBloc categoriesBloc;


  Evaluar({this.documentData, this.categoriesBloc});

  @override
  _EvaluarState createState() => _EvaluarState();
}

final databaseReference = Firestore.instance;

class _EvaluarState extends State<Evaluar> {
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFF05C3DD),
                //Colors.deepPurpleAccent,
                const Color(0xFF87189d),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Image.network("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2FLOGO-IVERUS-NEGRO.png?alt=media&token=af898df2-cd8d-44f8-bc83-864000bab447",
                ),
                height: deviceSize.height /2.5,
                width: deviceSize.width / 2.5,
              ),

              Text('¿Te Gusto el Contenido?',
                style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "Agne",
                    color: Colors.white
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AvatarGlow(
                    glowColor: Colors.red,
                    endRadius: 90.0,
                    duration: Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: Duration(milliseconds: 100),
                    child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: InkWell(
                          child: Icon(
                              Icons.cancel,
                              size: 50.0
                          ),
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ));
                            var data =   databaseReference.collection("iverus_trivia").document(widget.documentData.tipo).get()
                                .then((doc)=>{
                              if(doc.exists){
                                databaseReference.collection("iverus_trivia")
                                    .document(widget.documentData.tipo).updateData({"no":doc.data['no'] + 1})
                              }  else{
                                print('"No such document!"')
                              }
                            });

                          },
                        ),
                        radius: 40.0,
                      ),
                    ),
                  ),
                  AvatarGlow(
                    glowColor: Colors.green,
                    endRadius: 90.0,
                    duration: Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: Duration(milliseconds: 100),
                    child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child:InkWell(
                          child: Icon(
                            Icons.check_circle,
                            size: 50.0,
                          ),
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ));
                            var data =   databaseReference.collection("iverus_trivia").document(widget.documentData.tipo).get()
                                .then((doc)=>{
                                  if(doc.exists){
                                    databaseReference.collection("iverus_trivia")
                                    .document(widget.documentData.tipo).updateData({"si":doc.data['si'] + 1})
                                  }  else{
                                    print('"No such document!"')
                                  }
                                 });

                          },
                        ),
                        radius: 40.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


