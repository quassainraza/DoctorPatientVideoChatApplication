import 'package:doctor_app/data/json.dart';
import 'package:doctor_app/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../widgets/appointment_card.dart';
import 'NavBar.dart';


class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}


enum FilterStatus {upcoming, previous}

class _AppointmentsPageState extends State<AppointmentsPage> {

    FilterStatus status = FilterStatus.upcoming;
    Alignment alignment = Alignment.centerLeft;

    List<dynamic> schedules = [
      {
        "doctor_info": doctors[0],
        "status": FilterStatus.upcoming
      },
      {
        "doctor_info": doctors[1],
        "status": FilterStatus.upcoming
      },
      {
        "doctor_info": doctors[2],
        "status": FilterStatus.upcoming
      },
      {
        "doctor_info": doctors[3],
        "status": FilterStatus.previous
      },


    ];


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
                    backgroundImage:AssetImage(
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
    List<dynamic> filteredSchdeules = schedules.where((var schedule){

      // switch(schedule['status']){
      //   case 'upcoming':
      //     schedule['status'] = FilterStatus.upcoming;
      //     break;
      //   case 'previous':
      //     schedule['status'] = FilterStatus.previous;
      //     break;
      // }
      return schedule['status']== status;
    }).toList();


    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 7,
            decoration: BoxDecoration(
              color: Color(0xff2b67db),
            ),
            child: Stack(

              children: [
                Center(
                  child: Container(

                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for(FilterStatus filterstatus in FilterStatus.values)
                          Expanded(
                            child:GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(filterstatus == FilterStatus.upcoming) {
                                    status =FilterStatus.upcoming;
                                    alignment = Alignment.centerLeft;
                                  }else{
                                    status =FilterStatus.previous;
                                    alignment = Alignment.centerRight;
                                  }
                                });
                              },
                              child: Center(
                                child: Text(filterstatus.name),
                              ),
                            )
                          ),

                      ],
                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: AnimatedAlign(
                      alignment: alignment,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),

                        ),
                        child: Center(
                          child: Text(
                            status.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 7 - 10 - 56 - 25),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredSchdeules.length,
                  itemBuilder: (context, index) {
                    var schedule = filteredSchdeules[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: AppointmentCard(doctor: schedule['doctor_info']),
                    );
                  },
                ),
              ),
            ),
          )
        ]
      )


    );
  }
}
