import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ResetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<ResetPassword> {
  TextEditingController email = TextEditingController();

  
  _PassReset() async {
     FirebaseAuth.instance
        .sendPasswordResetEmail(
    email: email.text.trim(),
    ).catchError((msg) {
    Navigator.pop(context);
    Fluttertoast.showToast(msg: "Error" + msg.toString());
    });
     Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }



  initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                    color: new Color(0xffF5591F),
                    gradient: LinearGradient(
                      colors: [(new Color(0xff2b67db)), new Color(0xff7994d7)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20, top: 20),
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Reset Password",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )
                        ],
                      )),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: TextField(
                    controller: email,
                    cursorColor: Color(0xff2b67db),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Color(0xff2b67db),
                      ),
                      hintText: "Enter Email",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffEEEEEE),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),

                ),
                GestureDetector(
                  onTap: () {
                    _PassReset();
                    // Write Click Listener Code Here.
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [(new Color(0xff2b67db)), new Color(0xff7994d7)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: Text(
                      "Reset Password",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )));
  }
}
