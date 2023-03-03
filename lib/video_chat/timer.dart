import 'package:doctor_app/data/json.dart';
import 'package:doctor_app/video_chat/video_chat.dart';
import 'package:doctor_app/video_chat/views/chat_screen.dart';
import 'package:doctor_app/widgets/avatar_image.dart';
import 'package:flutter/material.dart';

class BookingTimerPage extends StatefulWidget {
  const BookingTimerPage({ Key? key, required this.i }) : super(key: key);

  final int i;
  @override
  _BookingTimerPageState createState() => _BookingTimerPageState();
}

class _BookingTimerPageState extends State<BookingTimerPage> {
  DateTime _selecteddate = DateTime.now();
  String? selectedtime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdff0ff),
      appBar: AppBar(
        elevation: 0,
        title: Text("Booking", style: TextStyle(color: Colors.white),),
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AvatarImage( doctors[widget.i]['image'].toString(),
              radius: 10,width: 50,height: 2,borderColor: Colors.white,
            ),
          )
        ],
      ),
      body: getBody(),
    );
  }

  getBody(){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Color(0xff2b67db),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 10,),
                      AvatarImage(doctors[widget.i]['image'].toString(), radius: 10,width: 100,height: 100,borderColor: Colors.white,),
                      SizedBox(height: 5,),
                      Text(doctors[widget.i]['name'].toString(), style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.w700)),
                      SizedBox(height: 40,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                        Icon(Icons.access_time,color: Colors.white,size: 20,),
                          SizedBox(height: 10, ),
                          Text("Booking Time Left", style: TextStyle(color: Colors.grey, fontSize: 14),),
                          SizedBox(height: 5, ),
                          Text("00: 00: 00", style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.w800),),
                        ],

                      ),

                    ],
                  ),
                ],
              )
          ),
          SizedBox(height: 20, ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.white60),
                    ),
                    leading: IconButton(onPressed:(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoChat(),
                          ));
                    }, icon: Icon(Icons.video_call,color: Colors.green,)),
                    tileColor: Colors.white,
                    title: Text("Join Video Chat",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.green),textAlign: TextAlign.center,),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>ChatScreen(),
                          ));
                    },
                  ),
                ),






              ],
            ),
          ),
        ],
      ),
    );
  }

}