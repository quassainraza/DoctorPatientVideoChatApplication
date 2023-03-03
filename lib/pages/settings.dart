import 'package:doctor_app/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {






  Future<String> getProfileImage() async {

    User? firebaseUser = FirebaseAuth.instance.currentUser;
    final _storageRef = FirebaseStorage.instance.ref().child('Images/Profile/${firebaseUser!.uid}');
    String imageUrl = await _storageRef.getDownloadURL();
    return imageUrl;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdff0ff),
      appBar: AppBar(
        elevation: 0,
        title: Text("Settings", style: TextStyle(color: Colors.black54),),
        centerTitle: true,
        backgroundColor: Color(0xffdff0ff),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),

        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: FutureBuilder(
              future: getProfileImage(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(snapshot.data ?? ""),
                  );
                } else {
                  return CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(
                        'assets/Images/person.png'),
                  );
                }
              },
            ),
          ),
        ],
      ),
      body: getBody(),
    );
  }
  getBody(){
    return
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(child: Text("Your Settings", style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w800),),),
                SizedBox(height: 5,),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.white60),
                  ),
                  tileColor: Colors.white,
                  leading: Icon(
                    Icons.info_outline_rounded,
                    color: Colors.blue,
                  ),
                  title: Text("About Us", style: TextStyle(fontWeight: FontWeight.w700),),
                  onTap: () {
                  },
                ),
                SizedBox(height: 8,),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.white60),
                  ),
                  tileColor: Colors.white,
                  leading: Icon(
                    CupertinoIcons.bell,
                    color: Colors.blue,
                  ),
                  title: Text("Notifications",style: TextStyle(fontWeight: FontWeight.w700),),
                  onTap: () {
                  },
                  trailing: Container(
                    width: 70,
                    child: CupertinoSlider(

                      value: 0,
                      onChanged: (value) {

                      },
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.white60),
                  ),
                  tileColor: Colors.white,
                  leading: Icon(
                    Icons.lock,
                    color: Colors.blue,
                  ),
                  title: Text("Privacy & Security",style: TextStyle(fontWeight: FontWeight.w700),),
                  onTap: () {
                  },
                ),
                SizedBox(height: 8,),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.white60),
                  ),
                  tileColor: Colors.white,
                  leading: Icon(
                    Icons.article_outlined,
                    color: Colors.blue,
                  ),
                  title: Text("Terms",style: TextStyle(fontWeight: FontWeight.w700),),
                  onTap: () {
                  },
                ),
                SizedBox(height: 8,),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.white60),
                  ),
                  tileColor: Colors.white,
                  leading: Icon(
                    Icons.headphones_outlined,
                    color: Colors.blue,
                  ),
                  title: Text("Help & Support",style: TextStyle(fontWeight: FontWeight.w700),),
                  onTap: () {
                  },
                ),

              ],
            ),
          ),


        );

  }

}
