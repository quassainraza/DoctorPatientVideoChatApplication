import 'package:flutter/material.dart';


class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),

      ),
      width: 100,
      height: 20,
      padding: const EdgeInsets.all(20),
      child: Row(
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
           SizedBox(width: 20,),
           IconButton(
            icon: Icon(Icons.more_vert_rounded),
            color: Colors.black,
            iconSize: 25,
            onPressed: () {
            },
          ),


        ],
      ),
    );
  }
}
