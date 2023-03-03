import 'package:doctor_app/data/json.dart';
import 'package:doctor_app/pages/doctor_profile_page.dart';
import 'package:doctor_app/pages/profile.dart';
import 'package:doctor_app/widgets/doctor_box.dart';
import 'package:doctor_app/widgets/textbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../widgets/filter_box.dart';
import 'NavBar.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({ Key? key }) : super(key: key);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {

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
        title: Text("Doctor Care"),
        centerTitle: true,
        backgroundColor: Color(0xff2b67db),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child:  FutureBuilder(
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
      drawer: NavBar(),
      body: getBody(),
    );
  }

  getBody(){
    return 
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.10,
              decoration: BoxDecoration(
                color: Color(0xff2b67db),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomTextBox(),
                          SizedBox(width: 10,),
                          CustomFilterBox(),
                        ],
                      ),
                      SizedBox(height: 5,),
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     children: List.generate(chatsData.length, (index) =>
                      //      Padding(
                      //        padding: const EdgeInsets.only(right: 10),
                      //        child: Badge1.Badge(
                      //           badgeColor: Colors.green,
                      //           borderSide: BorderSide(color: Colors.white),
                      //           position: BadgePosition.topEnd(top: -3, end: 0),
                      //           badgeContent: Text(''),
                      //           child: AvatarImage(chatsData[index]["image"].toString())
                      //         ),
                      //      )
                      //     )
                      //   ),
                      // ),

                    ]
                )
              ),
            ),
            SizedBox(height: 5,),
            getDoctorList(),
          ],
        )
      );
  }

  getDoctorList(){
    return 
      new StaggeredGridView.countBuilder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          itemCount: doctors.length,
          itemBuilder: (BuildContext context, int index) => 
            DoctorBox(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DoctorProfilePage(i:index)));
              },
              index: index, doctor: doctors[index]
            ),
          staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 3 : 2),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        );
  }

}