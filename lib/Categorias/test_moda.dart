import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CommonThings {
  static Size size;
}

class TestModaPage extends StatefulWidget {
  @override
  _TestModaPageState createState() => _TestModaPageState();
}

class _TestModaPageState extends State<TestModaPage> {

  TextEditingController phoneInputController;
  TextEditingController nameInputController;
  String id;
  final db = Firestore.instance;
  String name;
  String phone;

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('moda').document(doc.documentID).delete();
    setState(() => id = null);
  }

  @override
  Widget build(BuildContext context) {

    CommonThings.size = MediaQuery.of(context).size;
    //print('Width of the screen: ${CommonThings.size.width}');
    return new Scaffold(
      appBar: AppBar(
        title: Text('Moda'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("moda").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("loading....");
          }
          int length = snapshot.data.documents.length;

          return ListView.builder(
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