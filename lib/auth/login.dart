import 'package:doctor_app/auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../pages/home.dart';
import '../widgets/progressdialog.dart';
import 'forgetpassword.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  _validateUser() {
    if (!email.text.contains("@")) {
      Fluttertoast.showToast(msg: "email is not correct!");
    } else if (password.text.isEmpty) {
      Fluttertoast.showToast(msg: "password is required!");
    } else {
      _logintheuser();
    }
  }

  _logintheuser() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Processing Please wait...",
          );
        });
    final User? firebaseUser = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    ).catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error" + msg.toString());
    })).user;

    if(firebaseUser!=null){
      Fluttertoast.showToast(msg: "Login Successful!");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (c) => Home()));
    }else{
      Fluttertoast.showToast(msg: "User Not found!");
  }

    /////////////
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
                  "Login",
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
          child: TextField(
            controller: password,
            keyboardType: TextInputType.text,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            cursorColor: Color(0xff2b67db),
            decoration: InputDecoration(
              focusColor: Color(0xff2b67db),
              icon: Icon(
                Icons.vpn_key,
                color: Color(0xff2b67db),
              ),
              hintText: "Enter Password",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              // Write Click Listener Code Here
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResetPassword(),
                  ));
            },
            child: Text(
              "Forget Password?",
              style: TextStyle(color: Color(0xff2b67db)),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _validateUser();
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
              "LOGIN",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't Have Any Account?  "),
              GestureDetector(
                child: Text(
                  "Register Now",
                  style: TextStyle(color: Color(0xff2b67db)),
                ),
                onTap: () {
                  // Write Tap Code Here.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ));
                },
              )
            ],
          ),
        )
      ],
    )));
  }
}
