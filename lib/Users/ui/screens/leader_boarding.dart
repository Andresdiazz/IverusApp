import 'package:cocreacion/Users/bloc/home_bloc.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class LeaderBoarding extends StatefulWidget {
  @override
  _LeaderBoardingState createState() => _LeaderBoardingState();
}

class _LeaderBoardingState extends State<LeaderBoarding> {
  HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<HomeBloc>(context);

    final lives = Column(
      children: <Widget>[
        Center(
          child: Text(
            "20",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Center(
          child: Text(
            "Lives",
            style: TextStyle(color: Colors.white, fontFamily: "Lato"),
          ),
        )
      ],
    );

    final video = Column(
      children: <Widget>[
        Center(
          child: Text(
            "20",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Center(
          child: Text(
            "Videos",
            style: TextStyle(color: Colors.white, fontFamily: "Lato"),
          ),
        )
      ],
    );

    final share = Column(
      children: <Widget>[
        Center(
          child: Text(
            "20",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Center(
          child: Text(
            "Share",
            style: TextStyle(color: Colors.white, fontFamily: "Lato"),
          ),
        )
      ],
    );

    return StreamBuilder<List<User>>(
      stream: homeBloc.leaderBoard,
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[lives, video, share],
                  ),
                ),
              ),
              SizedBox(height: 30),
//                Padding(
//                  padding: const EdgeInsets.all(12.0),
//                  child: Row(
//                    children: <Widget>[
//                      SizedBox(
//                        width: MediaQuery.of(context).size.width * 0.22,
//                        child: Align(
//                          child: Text(
//                            "Image",
//                            style: TextStyle(
//                                fontSize: 15,
//                                color: Colors.indigoAccent,
//                                fontWeight: FontWeight.bold),
//                          ),
//                          alignment: Alignment(-1, 0),
//                        ),
//                      ),
//                      SizedBox(
//                        width: MediaQuery.of(context).size.width * 0.3,
//                        child: Align(
//                            child: Text(
//                              "Name",
//                              style: TextStyle(
//                                  fontSize: 15,
//                                  color: Colors.indigoAccent,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                            alignment: Alignment(-1, 0)),
//                      ),
//                      SizedBox(
//                        width: MediaQuery.of(context).size.width * 0.22,
//                        child: Align(
//                            child: Text(
//                              "Points",
//                              style: TextStyle(
//                                  fontSize: 15,
//                                  color: Colors.indigoAccent,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                            alignment: Alignment(-1, 0)),
//                      ),
//                      Align(
//                          child: Text(
//                            "Points",
//                            style: TextStyle(
//                                fontSize: 15,
//                                color: Colors.indigoAccent,
//                                fontWeight: FontWeight.bold),
//                          ),
//                          alignment: Alignment(-1, 0)),
//                    ],
//                  ),
//                ),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: getPopulatedList(snapshot.data),
                ),
              )
//                Container(
//
//                  margin: EdgeInsets.only(left: 8,right: 8),
////                  width: 350,
//                  decoration: BoxDecoration(
//                    gradient: LinearGradient(
//                        colors: [
//                          Colors.white,
//                          Colors.white,
//                        ],
//                        stops: [
//                          0.4,
//                          0.30
//                        ],
//                        begin: Alignment.topLeft,
//                        end: Alignment.bottomLeft,
//                        tileMode: TileMode.repeated),
//                    borderRadius: BorderRadius.circular(20),
//                    boxShadow: const [
//                      BoxShadow(color: Colors.black, blurRadius: 20)
//                    ],
//                  ),
//                  child: Center(
//                    child: DataTable(
//                        columns: <DataColumn>[
//                          DataColumn(
//                            label: Text(
//                              "Image",
//                              style: TextStyle(
//                                  fontSize: 15,
//                                  color: Colors.indigoAccent,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                          DataColumn(
//                            label: Text(
//                              "Name",
//                              style: TextStyle(
//                                  fontSize: 15,
//                                  color: Colors.indigoAccent,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                          DataColumn(
//                              label: Text("Points",
//                                  style: TextStyle(
//                                      fontSize: 15,
//                                      color: Colors.indigoAccent,
//                                      fontWeight: FontWeight.bold))),
//                          DataColumn(
//                              label: Text("Gift",
//                                  style: TextStyle(
//                                      fontSize: 15,
//                                      color: Colors.indigoAccent,
//                                      fontWeight: FontWeight.bold)))
//                        ],
//                        rows: List.generate(snapshot.data.length,
//                            (index) => getDataRow(snapshot.data[index]))),
//                  ),
//                ),
            ],
          ),
        );
      },
    );
  }

  getDataRow(User user) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Card(
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(user.photoURL),
          ),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        )),
        DataCell(Text(user.name)),
        DataCell(CellText(
          color: Colors.amber,
          text: user.points.toString(),
          icon: Icons.local_parking,
        )),
        DataCell(CellText(
          color: Colors.lightGreen,
          text: user.gift != null ? user.gift : '--',
          icon: Icons.monetization_on,
        ))
      ],
    );
  }

  getPopulatedList(List<User> leaderboard) {
    return ListView.builder(
//        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(12),
        itemCount: leaderboard.length,
        itemBuilder: (context, i) {
//          var values = snapshot.data[i];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: Align(
                      child: CircleAvatar(
                        maxRadius: 20,
                        backgroundImage: NetworkImage(leaderboard[i].photoURL),
                      ),
                      alignment: Alignment(-1, 0),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Align(
                        child: Text(leaderboard[i].name),
                        alignment: Alignment(-1, 0)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: Align(
                        child: CellText(
                          color: Colors.amber,
                          text: leaderboard[i].points.toString(),
                          icon: Icons.local_parking,
                        ),
                        alignment: Alignment(-1, 0)),
                  ),
                  CellText(
                    color: Colors.lightGreen,
                    text: leaderboard[i].gift != null
                        ? leaderboard[i].gift
                        : '--',
                    icon: Icons.monetization_on,
                  ),
                ],
              ),
            ),
          );
        });
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
        Text(
          text,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        Icon(
          icon,
          color: color,
          size: 15,
        )
      ],
    ));
  }
}
