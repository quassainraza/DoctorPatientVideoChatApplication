import 'package:doctor_app/data/json.dart';
import 'package:doctor_app/pages/profile.dart';
import 'package:doctor_app/theme/colors.dart';
import 'package:doctor_app/widgets/chat_item.dart';
import 'package:flutter/material.dart';
import 'NavBar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({ Key? key }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
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
            child: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 50,
                ),
              ),

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    color: Color(0xff2b67db),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                        },
                        child: CircleAvatar(
                          radius: 50,
                          child: ClipOval(
                            child: Image.network(
                              'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                              fit: BoxFit.cover,
                              width: 170,
                              height: 150,
                            ),
                          ),

                        ),
                      ),
                      SizedBox(height: 10,),
                      Text("Patient's Name Here"
                        ,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.white),),


                    ],
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(height: 20,),
                getChatList()
              ]
          )
      );
  }

  getChatList(){
    return 
      Column(
        children: List.generate(
          chatsData.length,
         (index) => ChatItem(chatsData[index])
        )
      );
  }
}