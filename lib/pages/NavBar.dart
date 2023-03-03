import 'package:doctor_app/auth/login.dart';
import 'package:doctor_app/pages/AppointmentsPage.dart';
import 'package:doctor_app/pages/home.dart';
import 'package:doctor_app/pages/profile.dart';
import 'package:doctor_app/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'chat_page.dart';
import 'doctor_page.dart';
import 'global.dart';

class NavBar extends StatelessWidget {
  Future<String> getProfileImage() async {

    User? firebaseUser = FirebaseAuth.instance.currentUser;
    final _storageRef = FirebaseStorage.instance.ref().child('Images/Profile/${firebaseUser!.uid}');
    String imageUrl = await _storageRef.getDownloadURL();
    return imageUrl;
  }



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(patientModel.name!),
            accountEmail: Text(patientModel.email!),
            currentAccountPicture: FutureBuilder(
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
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.lightBlue,
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.event_note_rounded, color: Colors.lightBlue),
            title: Text('Appointments'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppointmentsPage()),
              );
            },
          ),
          ListTile(
            leading:
                Icon(Icons.medical_services_rounded, color: Colors.lightBlue),
            title: Text('Doctors'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoctorPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.category, color: Colors.lightBlue),
            title: Text('Category'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_circle_sharp, color: Colors.lightBlue),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.lightBlue),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Sign Out',
            ),
            leading: Icon(Icons.exit_to_app, color: Colors.lightBlue),
            onTap: () => {
              FirebaseAuth.instance.signOut().then((value) => {
                Fluttertoast.showToast(msg: "User SignOut"),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ))
                  })
            },
          ),
        ],
      ),
    );
  }
}
