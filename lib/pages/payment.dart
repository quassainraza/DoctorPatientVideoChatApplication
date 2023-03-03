import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../PaymentOptions/flutterwave.dart';
import '../PaymentOptions/paystack.dart';
import '../PaymentOptions/stripe.dart';
import '../video_chat/timer.dart';

class PaymentPage extends StatefulWidget {
   PaymentPage({ Key? key, required this.i }) : super(key: key);

   final int i;
  @override
  _PaymentPageState createState() => _PaymentPageState();
}


class _PaymentPageState extends State<PaymentPage> {
  final paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      backgroundColor: Color(0xffdff0ff),
      appBar: AppBar(
        elevation: 0,
        title: Text("Payment", style: TextStyle(color: Colors.white),),
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
  getBody() {
    return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  color: Color(0xff2b67db),
                ),
                    child: Column(
                      children: [
                        SizedBox(height: 80,),
                        Text(
                          "Amount",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "USD 15.00",
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
              ),
              Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child :Text(
                              "Make your payment!",
                              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                         Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.blueGrey),
                                ),
                                tileColor: Colors.white,
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:  AssetImage(
                                    "assets/Images/stripe.png",
                                  ),

                                ),

                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                                ),
                                title: Text(
                                  "Stripe",
                                  style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () => paymentController.makePayment(amount: "15", currency: "USD")
                              ),
                         ),

                        SizedBox(height: 5,),
                           Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.blueGrey),
                                ),
                               leading: CircleAvatar(
                                 radius: 20,
                                 backgroundImage:  AssetImage(
                                   "assets/Images/flutterwave.png",
                                 ),
                               ),
                                tileColor: Colors.white,
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                                ),
                                title: Text(
                                  "Flutterwave",
                                  style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyHomePage("Flutterwave"),
                                      ));
                                },
                              ),
                           ),

                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child :Text(
                              "Mobile Money Payment!",
                              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                         Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.blueGrey),
                                ),
                             leading: CircleAvatar(
                               radius: 20,
                               backgroundImage:  AssetImage(
                                 "assets/Images/Paystack.png",
                               ),
                             ),
                                tileColor: Colors.white,
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                                ),
                                title: Text(
                                  "PayStack",
                                  style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ));
                                },
                              ),
                         ),
                         SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.blueGrey),
                            ),
                            tileColor: Colors.white,
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                            ),
                            title: Text(
                              "Proceed",
                              style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>BookingTimerPage(i: widget.i) ,
                                  ));
                            },
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),

            ],
          );
  }
}
