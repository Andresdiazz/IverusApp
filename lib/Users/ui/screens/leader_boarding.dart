import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LeaderBoarding extends StatefulWidget {
  @override
  _LeaderBoardingState createState() => _LeaderBoardingState();
}

class _LeaderBoardingState extends State<LeaderBoarding> {

  @override
  Widget build(BuildContext context) {
    final lives = Column(
      children: <Widget>[
        Center(
          child: Text("20", style: TextStyle(
            color: Colors.white
          ),),
        ),
        Center(
          child: Text("Lives", style:  TextStyle(
            color: Colors.white,
            fontFamily: "Lato"
          ),),
        )
      ],
    );

    final video = Column(
      children: <Widget>[
        Center(
          child: Text("20", style: TextStyle(
              color: Colors.white
          ),),
        ),
        Center(
          child: Text("Videos", style:  TextStyle(
              color: Colors.white,
              fontFamily: "Lato"
          ),),
        )
      ],
    );

    final share = Column(
      children: <Widget>[
        Center(
          child: Text("20", style: TextStyle(
              color: Colors.white
          ),),
        ),
        Center(
          child: Text("Share", style:  TextStyle(
              color: Colors.white,
              fontFamily: "Lato"
          ),),
        )
      ],
    );





    return Column(
      children: <Widget>[
        Center(
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                lives,
                video,
                share
              ],
            ),
          ),
        ),
        SizedBox(height: 30),
        Container(
          //margin: EdgeInsets.only(top: 300),
          width: 350,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white,
              Colors.white,

            ],
            stops: [0.4, 0.30],
            begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              tileMode: TileMode.repeated
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.black, blurRadius: 20)
            ],
          ),
          child: Center(
            child: DataTable(
                columns: <DataColumn>[
                  DataColumn(label: Text("Name", style: TextStyle(
                      fontSize: 15,
                      color: Colors.indigoAccent,
                      fontWeight: FontWeight.bold
                  ),),
                  ),
                  DataColumn(label: Text("Points",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.indigoAccent,
                          fontWeight: FontWeight.bold
                      ))),
                  DataColumn(label: Text("Gift",style: TextStyle(
                      fontSize: 15,
                      color: Colors.indigoAccent,
                    fontWeight: FontWeight.bold
                  )))
                ], rows: <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text("Andres Diaz")),
                  DataCell(
                    CellText(
                      color: Colors.amber,
                      text: "300",
                      icon: Icons.local_parking,
                    )
                  ),
                  DataCell(
                    CellText(
                      color: Colors.lightGreen,
                      text: "1000",
                      icon: Icons.monetization_on,
                    )
                  )
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text("John")),
                  DataCell(
                    CellText(
                      color: Colors.amber,
                      text: "210",
                      icon: Icons.local_parking,
                    )
                  ),
                  DataCell(
                    CellText(
                      color: Colors.lightGreen,
                      text: "500",
                      icon: Icons.monetization_on,
                    )
                  )
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text("Maurico")),
                  DataCell(
                      CellText(
                        color: Colors.amber,
                        text: "100",
                        icon: Icons.local_parking,
                      )
                  ),
                  DataCell(
                      CellText(
                        color: Colors.lightGreen,
                        text: "200",
                        icon: Icons.monetization_on,
                      )
                  )
                ],
              )
            ]
            ),
          ),
        ),
      ],
    );
  }

}

class CellText extends StatelessWidget {

  String text;
  IconData icon;
  Color color;

  CellText({Key key, this.text, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
          children: <Widget>[
            Text(text,style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
            ),),
            Icon(icon,
              color: color,
              size: 15,)
          ],
        )
    );
  }
}



