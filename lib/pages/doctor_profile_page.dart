import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:doctor_app/data/json.dart';
import 'package:doctor_app/pages/payment.dart';
import 'package:doctor_app/widgets/avatar_image.dart';
import 'package:flutter/material.dart';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage( { Key? key ,required this.i}) : super(key: key);
  final int i;
  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  DateTime _selecteddate = DateTime.now();
  String? selectedtime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdff0ff),
      appBar: AppBar(
        elevation: 0,
        title: Text("Book Now", style: TextStyle(color: Colors.white),),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Container(
               width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height / 4,
               decoration: BoxDecoration(
                 color: Color(0xff2b67db),
      ),
            child: Column(
            children: [
              SizedBox(height: 50),
             Row(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 40,),
              AvatarImage(doctors[widget.i]['image'].toString(), radius: 10,width: 100,height: 100,borderColor: Colors.white,),
              SizedBox(width: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctors[widget.i]['name'].toString(), style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.w700)),
                  SizedBox(height: 5, ),
                  Text(doctors[widget.i]['skill'].toString(), style: TextStyle(color: Colors.grey, fontSize: 14),),
                  SizedBox(height: 15, ),
                  Container(
                      alignment: Alignment.center,
                      //margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      //  padding: EdgeInsets.only(left: 20, right: 20),
                      height: 30,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,

                      ),
                    child: TextButton(onPressed: (){}, child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 14,),
                        SizedBox(width: 5,),
                        Text("4.0", style: TextStyle(fontSize: 10,color: Colors.black, fontWeight: FontWeight.w700)),
                        SizedBox(width: 2, ),
                        Text(doctors[widget.i]['review'].toString() + " Reviews", style: TextStyle(color: Colors.black, fontSize: 10),),
                      ],
                    ),),
                  )
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
                 Container(
                      alignment: Alignment.topLeft,
                      child: Text("Description", style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w900),)
                 ),
                 SizedBox(height: 5, ),
                 SingleChildScrollView(
                     child: Text(
                       'This is a long description that could be several lines of text. It can contain multiple paragraphs and be formatted with various styles, such as bold, italic, or underlined.',
                       style: TextStyle(fontSize: 15,color: Colors.grey),
                     ),
                 ),
                 SizedBox(height: 15, ),
                 Container(
                     alignment: Alignment.topLeft,
                     child: Text("Schedules", style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w900),)
                 ),
                 SizedBox(height: 5, ),
                   Container(
                     child: DatePicker(
                       DateTime.now(),

                       height:100,
                       width: 80,
                       initialSelectedDate: DateTime.now(),
                       selectionColor:Color(0xff51db8e) ,
                       selectedTextColor: Colors.white,
                       dateTextStyle: TextStyle(
                         fontSize: 25,
                         fontWeight: FontWeight.w900,
                         color: Colors.black
                       ),
                       dayTextStyle: TextStyle(
                           fontSize: 15,
                           fontWeight: FontWeight.w800,
                           color: Colors.black
                       ),
                       onDateChange: (date){
                         _selecteddate=date;
                       },
                     ),
                   ),
                 SizedBox(height: 15, ),
                 Container(
                     alignment: Alignment.topLeft,
                     child: Text("Choose Time", style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w900),)
                 ),
                 SizedBox(height: 5,),
                 SingleChildScrollView(
                   padding: EdgeInsets.only(bottom: 0),
                   scrollDirection: Axis.horizontal,
                   child: Row(
                     children: [
                       GestureDetector(
                         onTap: () {
                           setState(() {
                             selectedtime = "8:30 AM";
                           });
                         },
                         child: Container(

                           padding: EdgeInsets.all(15),
                           width: 100,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: selectedtime == "8:30 AM" ? Color(0xff51db8e) : Colors.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.1),
                                 spreadRadius: 1,
                                 blurRadius: 1,
                                 offset: Offset(1, 1), // changes position of shadow
                               ),
                             ],
                           ),
                           child: Text(
                               "8:30 AM", style: TextStyle(color: selectedtime == "8:30 AM" ? Colors.white : Colors.black, fontSize: 16,fontWeight: FontWeight.w400)
                           ),
                         ),
                       ),
                       SizedBox(width: 8,),
                       GestureDetector(
                         onTap: () {
                           setState(() {
                             selectedtime = "9:00 AM";
                           });
                         },
                         child: Container(
                           padding: EdgeInsets.all(15),
                           width: 100,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: selectedtime == "9:00 AM" ? Color(0xff51db8e) : Colors.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.1),
                                 spreadRadius: 1,
                                 blurRadius: 1,
                                 offset: Offset(1, 1), // changes position of shadow
                               ),
                             ],
                           ),
                           child: Text(
                               "9:00 AM", style: TextStyle(color: selectedtime == "9:00 AM" ? Colors.white : Colors.black, fontSize: 16,fontWeight: FontWeight.w400)
                           ),
                         ),
                       ),
                       SizedBox(width: 8,),
                       GestureDetector(
                         onTap: () {
                           setState(() {
                             selectedtime = "9:30 AM";
                           });
                         },

                         child: Container(
                           padding: EdgeInsets.all(15),
                           width: 100,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: selectedtime == "9:30 AM" ? Color(0xff51db8e) : Colors.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.1),
                                 spreadRadius: 1,
                                 blurRadius: 1,
                                 offset: Offset(1, 1), // changes position of shadow
                               ),
                             ],
                           ),
                           child: Text(
                               "9:30 AM", style: TextStyle(color: selectedtime == "9:30 AM" ? Colors.white : Colors.black, fontSize: 16,fontWeight: FontWeight.w400)
                           ),
                         ),
                       ),
                       SizedBox(width: 8,),
                       GestureDetector(
                         onTap: () {
                           setState(() {
                             selectedtime = "10:00 AM";
                           });
                         },


                         child: Container(
                           padding: EdgeInsets.all(15),
                           width: 100,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: selectedtime == "10:00 AM" ? Color(0xff51db8e) : Colors.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.1),
                                 spreadRadius: 1,
                                 blurRadius: 1,
                                 offset: Offset(1, 1), // changes position of shadow
                               ),
                             ],
                           ),
                           child: Text(
                               "10:00 AM", style: TextStyle(color: selectedtime == "10:00 AM" ? Colors.white : Colors.black, fontSize: 16,fontWeight: FontWeight.w400)
                           ),
                         ),
                       ),
                       SizedBox(width: 8,),
                       GestureDetector(
                         onTap: () {
                           setState(() {
                             selectedtime = "10:30 AM";
                           });
                         },
                         child: Container(
                           padding: EdgeInsets.all(15),
                           width: 100,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: selectedtime == "10:30 AM" ? Color(0xff51db8e) : Colors.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.1),
                                 spreadRadius: 1,
                                 blurRadius: 1,
                                 offset: Offset(1, 1), // changes position of shadow
                               ),
                             ],
                           ),
                           child: Text(
                               "10:30 AM", style: TextStyle(color: selectedtime == "10:30 AM" ? Colors.white : Colors.black, fontSize: 16,fontWeight: FontWeight.w400)
                           ),
                         ),
                       ),
                       SizedBox(width: 8,),
                       GestureDetector(
                         onTap: () {
                           setState(() {
                             selectedtime = "11:00 AM";
                           });
                         },
                         child: Container(
                           padding: EdgeInsets.all(15),
                           width: 100,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: selectedtime == "11:00 AM" ? Color(0xff51db8e) : Colors.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.1),
                                 spreadRadius: 1,
                                 blurRadius: 1,
                                 offset: Offset(1, 1), // changes position of shadow
                               ),
                             ],
                           ),
                           child: Text(
                               "11:00 AM", style: TextStyle(color: selectedtime == "11:00 AM" ? Colors.white : Colors.black, fontSize: 16,fontWeight: FontWeight.w400)
                           ),
                         ),
                       ),
                       SizedBox(width: 8,),

                     ],
                   ),
                 ),

                 SizedBox(height: 15,),
                 Container(
                     alignment: Alignment.topLeft,
                     child: Text("Note", style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w900),)
                 ),
                 SizedBox(height: 5,),
                 Container(
                     color: Colors.white,
                     height: 120,
                     width: MediaQuery.of(context).size.width,
                     alignment: Alignment.topLeft,
                     child: Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: TextField(
                         maxLines: 5,
                         keyboardType: TextInputType.text,
                         textAlign: TextAlign.start,

                         decoration: InputDecoration(
                           //hintText: 'Write your note here',
                           //border: OutlineInputBorder(),
                         ),

                       ),
                     )
                 ),
                 SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: ListTile(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10.0),
                       side: BorderSide(color: Colors.white60),
                     ),
                     tileColor: Color(0xff2b67db),
                     trailing: IconButton(onPressed:(){
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => PaymentPage(i: widget.i),
                           ));
                     }, icon: Icon(Icons.arrow_forward_ios,color: Colors.white,)),
                     title: Text("Book Appointment",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),textAlign: TextAlign.center,),
                     onTap: () {
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => PaymentPage(i: widget.i),
                           ));
                     },
                   ),
                 ),
                 SizedBox(height: 10,),





               ],
             ),
           ),
        ],
      ),
    );
  }

}