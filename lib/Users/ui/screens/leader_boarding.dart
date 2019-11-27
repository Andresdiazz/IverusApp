import 'package:cocreacion/Users/bloc/home_bloc.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class LeaderBoarding extends StatefulWidget {
  @override
  _LeaderBoardingState createState() => _LeaderBoardingState();
}

class _LeaderBoardingState extends State<LeaderBoarding> {
  HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<HomeBloc>(context);

    final lives = StreamBuilder<User>(
      stream: homeBloc.user,
      builder: (context, AsyncSnapshot<User> snapshot) {
        return Column(
          children: <Widget>[
            Center(
                child: Row(
              children: <Widget>[
                Text(
                  snapshot.data.puntos == null
                      ? "0"
                      : snapshot.data.puntos.toString(),
                  style: TextStyle(color: Colors.white, fontFamily: "Aileron"),
                ),
                Icon(
                  Icons.offline_pin,
                  size: 18,
                  color: Colors.pinkAccent,
                )
              ],
            )),
            Center(
              child: Text(
                "Quiz",
                style: TextStyle(color: Colors.white, fontFamily: "Aileron"),
              ),
            )
          ],
        );
      },
    );

    final video = StreamBuilder<int>(
      stream: homeBloc.videosCount,
      builder: (context, AsyncSnapshot<int> snapshot) {
        return Column(
          children: <Widget>[
            Center(
                child: Row(
              children: <Widget>[
                Text(
                  snapshot.data == null ? "0" : snapshot.data.toString(),
                  style: TextStyle(color: Colors.white, fontFamily: "Aileron"),
                ),
                Icon(
                  Icons.video_library,
                  size: 18,
                  color: Colors.deepOrange,
                )
              ],
            )),
            Center(
              child: Text(
                "Videos",
                style: TextStyle(color: Colors.white, fontFamily: "Aileron"),
              ),
            )
          ],
        );
      },
    );

    final share = StreamBuilder<User>(
      stream: homeBloc.user,
      builder: (context, AsyncSnapshot<User> snapshot) {
        return Column(
          children: <Widget>[
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  snapshot.data == null ||
                          snapshot.data.shares == null ||
                          snapshot.data.shares.length == 0
                      ? "No shares"
                      : snapshot.data.shares.length.toString(),
                  style: TextStyle(color: Colors.white, fontFamily: "Aileron"),
                ),
                Icon(
                  FontAwesomeIcons.shareSquare,
                  size: 18,
                  color: Colors.lightGreen,
                )
              ],
            )),
            Center(
              child: Text(
                "Share",
                style: TextStyle(color: Colors.white, fontFamily: "Aileron"),
              ),
            )
          ],
        );
      },
    );

    final points = StreamBuilder<User>(
      stream: homeBloc.user,
      builder: (context, AsyncSnapshot<User> snapshot) {
        return Column(
          children: <Widget>[
            Center(
                child: Row(
              children: <Widget>[
                Text(
                  snapshot.data == null ||
                          snapshot.data.points == null ||
                          snapshot.data.points == 0
                      ? "0"
                      : snapshot.data.points.toString(),
                  style: TextStyle(color: Colors.white, fontFamily: "Aileron"),
                ),
                Icon(
                  Icons.local_parking,
                  size: 18,
                  color: Colors.amber,
                )
              ],
            )),
            Center(
              child: Text(
                "Points",
                style: TextStyle(color: Colors.white, fontFamily: "Aileron"),
              ),
            )
          ],
        );
      },
    );

    return StreamBuilder<List<User>>(
      stream: homeBloc.leaderBoard,
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.66,
          child: Column(
            children: <Widget>[
              StreamBuilder<User>(
                  stream: homeBloc.user,
                  builder: (context, snapshot) {
                    return Container(
                      margin: const EdgeInsets.only(left: 40),
                      alignment: Alignment(-1, 0),
                      child: Text(
                        snapshot.data == null || snapshot.data.desc == null
                            ? ""
                            : snapshot.data.desc,
                        style: Theme.of(context).textTheme.body2.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: "Aileron"),
                      ),
                    );
                  }),

              SizedBox(height: 20),

              Center(
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[points, lives, video, share],
                  ),
                ),
              ),
              SizedBox(height: 30),

              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: snapshot.data != null
                        ? getPopulatedList(snapshot.data)
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 80, bottom: 8),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    backgroundColor: Colors.white,
                                  ),
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  "Getting LeaderBoard",
                                  style: Theme.of(context)
                                      .textTheme
                                      .body2
                                      .copyWith(
                                          color: Colors.white,
                                          fontFamily: "Aileron",
                                          fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                  ),
                ),
              ) //                Container(
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

  getPopulatedList(List<User> leaderboard) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
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
                      child: Stack(
                        children: <Widget>[
                          CircleAvatar(
                            maxRadius: 20,
                            backgroundImage: leaderboard[i].photoURL == null
                                ? NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2Fprofile.jpg?alt=media&token=7621fac2-a428-44df-ab06-0336740602d7")
                                : NetworkImage(leaderboard[i].photoURL),
                          ),
                          leaderboard[i].rank != null
                              ? Align(
                                  child: Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                          color: Colors.cyan,
                                          borderRadius:
                                              BorderRadius.circular(32)),
                                      child: Center(
                                        child: Text(
                                          leaderboard[i].rank.toString(),
                                          style: TextStyle(
                                              fontFamily: "Aileron",
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  alignment: Alignment(0, 1))
                              : Container()
                        ],
                      ),
                      alignment: Alignment(-1, 0),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Align(
                        child: Text(
                          leaderboard[i].name,
                          style: TextStyle(
                              fontFamily: "Aileron", fontWeight: FontWeight.w600
                              //fontSize: 12
                              ),
                        ),
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
              fontStyle: FontStyle.italic,
              fontFamily: "Aileron"),
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
