import 'package:doctor_app/video_chat/video_chat.dart';
import 'package:flutter/material.dart';
import 'avatar_image.dart';

class AppointmentCard extends StatelessWidget {
   AppointmentCard({Key? key,  required this.doctor}) : super(key: key);

  final doctor;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
               alignment: Alignment.topLeft
                ,child: Text("Appointment Date",style: TextStyle(color: Colors.grey,fontSize: 12),textAlign: TextAlign.start,)),
            SizedBox(height: 2,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.access_time_outlined,
                  color: Colors.grey,
                  size: 15,
                ),
                SizedBox(width: 5,),
                Text(
                  'Wed June 2023',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 10,),
                Text(
                  '8:00 - 8:30 AM',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 30,),
                IconButton(
                  icon: Icon(Icons.more_vert_rounded),
                  color: Colors.black,
                  iconSize: 25,
                  alignment: Alignment.bottomRight,
                  onPressed: () {
                  },
                ),


              ],
            ),
            Divider(thickness: 1,),

            Row(
              children: [
               Stack
                 (children: [
                 AvatarImage(doctor["image"]),
                 Positioned(
                   bottom: -12,
                   right: -5,
                   child: IconButton(
                     icon: Icon(Icons.video_call),
                     color: Colors.green,
                     iconSize: 30,
                     onPressed: () {

                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => VideoChat()),
                       );
                     },
                   ),
                 ),
                 ] ),

                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor["name"], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                    SizedBox(height: 3,),
                    Text(doctor["skill"], style: TextStyle(fontSize: 12, color: Colors.grey),),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 14,),
                        SizedBox(width: 2,),
                        Text("${doctor["review"]} Review", style: TextStyle(fontSize: 12),)
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        )
    );
  }
}
