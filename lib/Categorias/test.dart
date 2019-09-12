import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CommonThings {
  static Size size;
}

class MyListPage extends StatefulWidget {
  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {

  // declarmos la instancia con firebase
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: AppBar(
        title: Text('View Page1'),
      ),
      body: StreamBuilder(
        stream: db.collection("moda").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("loading....");
          }
          int length = snapshot.data.documents.length;

          return GridView.builder(
            itemCount: length,
            itemBuilder: (_, int index) {
              final DocumentSnapshot doc = snapshot.data.documents[index];
              return new Container(
               // padding: new EdgeInsets.all(1.0),
                child: Card(
                  child: Row(
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.all(5.0),
                        child: Image.network(
                          '${doc.data["image"]}' + '?alt=media',
                        ),
                        width: 360,
                        height: 360,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}