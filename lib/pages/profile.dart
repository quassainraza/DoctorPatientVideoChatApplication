import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/progressdialog.dart';
import 'global.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final Permission _permission = Permission.photos;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();

    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() async {
    final status = await _permission.status;
    setState(() => _permissionStatus = status);
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  String? ImageUrl;

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
      updateinfotoFirebase();
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

  updateinfotoFirebase() async{
    showdialogbox();
    final User? firebaseUser = FirebaseAuth.instance.currentUser!;

    try{
      await firebaseUser?.updateEmail(email.text.trim());
      await firebaseUser?.updatePassword(password.text.trim());
      Navigator.pop(context);

    }catch(error){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to update email & password'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      });

    }

    if(firebaseUser!=null){

      //save info to firebase
      Map patientsmap = {
        "id": firebaseUser.uid,
        "name": name.text.trim(),
        "email": email.text.trim(),
        "mode": "Patient",
        "Address": address.text.trim(),
      };
      DatabaseReference usersref =
      FirebaseDatabase.instance.ref().child("Patients");
      usersref.child(firebaseUser.uid).set(patientsmap);
      Fluttertoast.showToast(msg: "Information Updated!");
    }else{
      Fluttertoast.showToast(msg: "Information cannot be updated!!");
    }

  }

  Future<String> getProfileImage() async {

    User? firebaseUser = FirebaseAuth.instance.currentUser;
    final _storageRef = FirebaseStorage.instance.ref().child('Images/Profile/${firebaseUser!.uid}');
    String imageUrl = await _storageRef.getDownloadURL();
    return imageUrl;
  }

  UploadImagetoFirebase() async{
    User? firebaseUser =  FirebaseAuth.instance.currentUser;
    //check for permisson
    final _storage= FirebaseStorage.instance;
    final _picker= ImagePicker();


      //select image
    final XFile? image= (await _picker.pickImage(source: ImageSource.gallery));

      try{
        var file= File(image!.path);
          //upload tofirebase
          await  _storage.ref()
              .child('Images/Profile/${firebaseUser!.uid}')
              .putFile(file)
              .whenComplete(() => null);
      }
      catch(error) {
        Fluttertoast.showToast(msg: "No File Selected");
      }
    }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdff0ff),
      appBar: AppBar(
        elevation: 0,
        title: Text("Profile", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xff2b67db),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),

        ),
      ),
      body: getBody(),
    );
  }
  getBody(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              color: Color(0xff2b67db),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    FutureBuilder(
                    future: getProfileImage(),
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(snapshot.data ?? ""),
                        );
                      } else {
                        return CircleAvatar(
                          radius: 45,
                            backgroundImage: AssetImage(
                                'assets/Images/person.png'),
                        );
                      }
                    },
                  ),
                    Positioned(
                      bottom: -12,
                      right: -5,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        color: Colors.blueGrey,
                        onPressed: () {
                          UploadImagetoFirebase();
                        },
                      ),
                    ),
                ],
                ),
                SizedBox(height: 5,),
                Text(patientModel.name!
                ,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.white),),
              ],
            ),
          ),

          SizedBox(height: 15,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                    child: TextField(

                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Email Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          gapPadding: 10.0,
                          borderSide: BorderSide(color: Colors.white, width: 2.0),

                        ),
                        prefixIcon: Icon(Icons.email_outlined,color: Colors.blue,),

                      ),
                    ),
                  ),
                SizedBox(height: 5,),
                Container(
                  color: Colors.white,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: phone,

                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'Phone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        gapPadding: 10.0,
                        borderSide: BorderSide(color: Colors.white, width: 2.0),

                      ),
                      prefixIcon: Icon(Icons.phone,color: Colors.blue,),

                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  color: Colors.white,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: password,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'Password',

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        gapPadding: 10.0,
                        borderSide: BorderSide(color: Colors.white, width: 2.0),

                      ),
                      prefixIcon: Icon(Icons.key,color: Colors.blue,),

                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  color: Colors.white,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        gapPadding: 10.0,
                        borderSide: BorderSide(color: Colors.white, width: 2.0),

                      ),
                      prefixIcon: Icon(Icons.person_outline_outlined,color: Colors.blue,),

                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  color: Colors.white,

                  width: MediaQuery.of(context).size.width,
                  child: TextField(

                      controller: address,
                      maxLines: 5,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        hintText: 'Residential Address',
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        gapPadding: 10.0,
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                        prefixIcon: Icon(Icons.location_on_outlined,color: Colors.blue,),
                      ),
                    ),
                ),
                SizedBox(height: 15,),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.white60),
                  ),
                  tileColor: Color(0xff2b67db),
                  trailing: IconButton(onPressed:(){
                    validateform();
                  }, icon: Icon(Icons.arrow_forward_ios,color: Colors.white,)),
                  title: Text("Save Changes",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),textAlign: TextAlign.center,),
                  onTap: () {
                    validateform();
                  },
                ),
                SizedBox(height: 8,),
              ],
            ),
          ),
        ],
      ),


    );
  }
}
