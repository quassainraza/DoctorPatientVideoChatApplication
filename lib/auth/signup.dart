import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../pages/home.dart';
import '../widgets/progressdialog.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) => initWidget();

  validateform() {
    if (name.text.length < 3) {
      Fluttertoast.showToast(msg: "name must be atleast 3 characters!!");
    } else if (!email.text.contains("@")) {
      Fluttertoast.showToast(msg: "email is not correct!");
    } else if (password.text.length < 6) {
      Fluttertoast.showToast(msg: "password must be atleast 6 characters!!");
    } else if (phone.text.isEmpty) {
      Fluttertoast.showToast(msg: "phone number is mandatory!!");
    } else {
      _signuptheuser();
    }
  }

  showdialogbox(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Processing Please wait...",
          );
        });
  }

  _signuptheuser() async{
   showdialogbox();
    final User? firebaseUser = (await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    ).catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error" + msg.toString());
    })).user;

    if(firebaseUser!=null){

      //save info to firebase
      Map patientsmap = {
        "id": firebaseUser.uid,
        "name": name.text.trim(),
        "email": email.text.trim(),
        "mode": "Patient",
        "Address": "",
      };
      DatabaseReference usersref =
      FirebaseDatabase.instance.ref().child("Patients");
      usersref.child(firebaseUser.uid).set(patientsmap);
      Fluttertoast.showToast(msg: "SignUp Successful!");
      Navigator.push(context,
          MaterialPageRoute(builder: (c) => Home()));
    }else{
      Fluttertoast.showToast(msg: "User Not created!!");
    }

  }

  Widget initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          height: 250,
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
                  "Register",
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
            controller: name,
            keyboardType: TextInputType.name,
            enableSuggestions: false,
            autocorrect: false,
            cursorColor: Color(0xff2b67db),
            decoration: InputDecoration(
              icon: Icon(
                Icons.person,
                color: Color(0xff2b67db),
              ),
              hintText: "Full Name",
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
            keyboardType: TextInputType.emailAddress,
            enableSuggestions: true,
            autocorrect: false,
            cursorColor: Color(0xff2b67db),
            decoration: InputDecoration(
              icon: Icon(
                Icons.email,
                color: Color(0xff2b67db),
              ),
              hintText: "Email",
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
            controller: phone,
            keyboardType: TextInputType.phone,
            enableSuggestions: true,
            autocorrect: false,
            cursorColor: Color(0xff2b67db),
            decoration: InputDecoration(
              focusColor: Color(0xff2b67db),
              icon: Icon(
                Icons.phone,
                color: Color(0xff2b67db),
              ),
              hintText: "Phone Number",
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
        GestureDetector(
          onTap: () {
            _signuptheuser();
            // Write Click Listener Code Here.
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20, right: 20, top: 30),
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
              "REGISTER",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Have Already Member?  "),
              GestureDetector(
                child: Text(
                  "Login Now",
                  style: TextStyle(color: Color(0xff2b67db)),
                ),
                onTap: () {
                  // Write Tap Code Here.
                  Navigator.pop(context);
                },
              )
            ],
          ),
        )
      ],
    )));
  }
}
