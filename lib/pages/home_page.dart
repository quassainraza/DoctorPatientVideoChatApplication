import 'package:doctor_app/data/json.dart';
import 'package:doctor_app/pages/AppointmentsPage.dart';
import 'package:doctor_app/pages/doctor_page.dart';
import 'package:doctor_app/pages/profile.dart';
import 'package:doctor_app/widgets/category_box.dart';
import 'package:doctor_app/widgets/popular_doctor.dart';
import 'package:doctor_app/widgets/textbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../widgets/appointment_card.dart';
import '../widgets/filter_box.dart';
import 'NavBar.dart';
import 'doctor_profile_page.dart';
import 'global.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  void initState(){
    super.initState();
    readCurrentOnlineUserInfo();
  }
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
      drawer: NavBar(),
      body: getBody(),

    );
  }

  readCurrentOnlineUserInfo() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? currentfirebaseuser = firebaseAuth.currentUser;
    await FirebaseDatabase.instance
        .ref()
        .child("Patients")
        .child(currentfirebaseuser!.uid)
        .once()
        .then((snap) {
      if (snap.snapshot.value != null) {
        patientModel.id = (snap.snapshot.value as dynamic)["id"];
        patientModel.name = (snap.snapshot.value as dynamic)['name'];
        patientModel.phone = (snap.snapshot.value as dynamic)["phone"];
        patientModel.email = (snap.snapshot.value as dynamic)["email"];
      }
    });
  }

  getBody(){
    return
      SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.48,
                decoration: BoxDecoration(
                  color: Color(0xff2b67db),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(child: Text("Good Morning,", style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w600),),),
                        SizedBox(height: 5,),
                        Container(child: Text("Welcome back", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),)),
                        SizedBox(height: 35,),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              CustomTextBox(),
                              SizedBox(width: 10,),
                              CustomFilterBox(),
                            ],
                          ),
                        ),

                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(child: Text("Find your Doctor", style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.w600),)),
                            TextButton(onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DoctorPage()),
                              );
                            },child:
                            Text("See all",style: TextStyle(color: Colors.grey,fontSize: 15),)),
                          ],
                        ),
                        SingleChildScrollView(
                          padding: EdgeInsets.all(5),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0; i < doctors.length; i++)
                                PopularDoctor(
                                  doctor: doctors[i],
                                  onTap: () {
                                    handleDoctorTap(i);
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                     ),
                ),
                ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(child: Text("Categories", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
                        TextButton(onPressed: (){},child:
                        Text("See all",style: TextStyle(color: Colors.grey,fontSize: 15),)),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:  Row(
                          children: [
                            CategoryBox(title: "Heart", icon: Icons.favorite, color: Color(0xff2b67db), ),
                            CategoryBox(title: "Medical", icon: Icons.local_hospital, color: Color(0xff2b67db)),
                            CategoryBox(title: "Dental", icon: Icons.details_rounded, color: Color(0xff2b67db) ),
                            CategoryBox(title: "Healing", icon: Icons.healing_outlined,color: Color(0xff2b67db),),
                          ],
                        ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(child: Text("Appointments", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
                        TextButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AppointmentsPage()),
                          );
                        },child:
                        Text("See all",style: TextStyle(color: Colors.grey,fontSize: 15),)),
                      ],
                    ),
                    SizedBox(height: 5,),
                    AppointmentCard(doctor: doctors[0],),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ]
          ),
      );
  }

  void handleDoctorTap(int i) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DoctorProfilePage( i: i,)),
    );
  }
}
