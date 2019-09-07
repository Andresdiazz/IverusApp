import 'dart:developer';

import 'package:cocreacion/Ideas/ui/screens/home_page.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'Users/bloc/bloc_user.dart';
import 'Users/model/user.dart';

class Authphone extends StatefulWidget {
  @override
  _AuthphoneState createState() => _AuthphoneState();
}

class _AuthphoneState extends State<Authphone> {
  UserBloc userBloc;

  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _smsController = new TextEditingController();

  String _phonecode;

  String verificationId;
  FirebaseUser user;
  var _keyField = GlobalKey<FormFieldState>();

  _buildCountryPickerDropdown() => Row(
        children: <Widget>[
          CountryPickerDropdown(
            initialValue: 'mx',
            itemBuilder: _buildDropdownItem,
            onValuePicked: (Country country) {
              print("${country.name}");
              print("${country.phoneCode}");
              setState(() {
                this._phonecode = country.phoneCode;
              });
            },
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: TextFormField(
              key: _keyField,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "Phone"),
              validator: (val) {
                if (val.isEmpty) {
                  return "this field cannot be empty";
                }
              },
            ),
          ),
        ],
      );

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}(${country.isoCode})"),
          ],
        ),
      );

//Verificar_Telefono

  Future<void> verifyPhone(BuildContext context) async {
    try {
      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
        this.verificationId = verId;
      };

      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        this.verificationId = verId;
        smsCodeDialog(context).then((value) {
          print('Signed in');
        });
      };

      final PhoneVerificationCompleted verifiedSuccess = (AuthCredential user) {
        print('Successful verification');
        if (user != null) {
          FirebaseAuth.instance.signInWithCredential(user).then((user) {
            userBloc.updateUserData(User(
              uid: user.user.uid,
              name: user.user.displayName,
              email: user.user.email,
              photoURL: user.user.photoUrl,
            ));
          });

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          print('user is null');
        }
      };

      final PhoneVerificationFailed veriFailed = (AuthException exception) {
        print('Failed verification: ${exception.message}');
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+${_phonecode + _phoneController.text.trim()}',
          timeout: const Duration(seconds: 5),
          verificationCompleted: verifiedSuccess,
          verificationFailed: veriFailed,
          codeSent: smsCodeSent,
          codeAutoRetrievalTimeout: autoRetrieve);
    } catch (e) {
      print("error: $e");
    }
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter sms Code'),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _smsController,
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Done'),
                onPressed: () async {
                  AuthCredential credential = PhoneAuthProvider.getCredential(
                    verificationId: this.verificationId,
                    smsCode: _smsController.text.trim(),
                  );

                  user = await FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      print("Successful verification user is: ${user}");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      print("Failed verification");
                    }
                  }).catchError((e) {
                    print("error: $e");
                  });
                },
              ),
            ],
          );
        });
  }

  flushBarMessage(BuildContext context, String msg) {
    Flushbar(
        message: "$msg",
        duration: Duration(seconds: 4),
        leftBarIndicatorColor: Colors.blue[300])
      ..show(context);
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);

    return SafeArea(
      child: new Scaffold(
        appBar: new AppBar(),
        body: new Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Autentificacion Telefono',
                      textAlign: TextAlign.center,
                      style: new TextStyle(fontSize: 24),
                    ),
                    ListTile(title: _buildCountryPickerDropdown()),
                  ],
                ),
              ),
              new RaisedButton(
                child: Text("Verificacion"),
                color: Colors.green.shade800,
                textColor: Colors.white,
                onPressed: () {
                  if (_phonecode != null) {
                    if (_keyField.currentState.validate()) {
                      print("+${_phonecode + _phoneController.text.trim()}");
                      verifyPhone(context);
                      log("funcion correctamente verificar");
                    }
                  } else {
                    flushBarMessage(context, "please select your code country");
                    log("errro");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
