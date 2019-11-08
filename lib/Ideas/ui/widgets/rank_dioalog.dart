import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RankDialog {
  showCongoRankDialog(BuildContext cntxt) {
    return showDialog(
        context: cntxt,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              'Congratulations',
              style: TextStyle(color: Colors.lightBlue),
            ),
            content: Text('You have got Rank 1 in this Session'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close')),
            ],
          );
        });
  }

  showRankDialog(BuildContext cntxt, int rank) {
    return showDialog(
        context: cntxt,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              'Better luck next time',
              style: TextStyle(color: Colors.lightBlue),
            ),
            content: Text('You have got Rank $rank in this Session'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close')),
            ],
          );
        });
  }
}
