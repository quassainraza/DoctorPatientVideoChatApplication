import 'package:doctor_app/widgets/progressdialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Patient_Model/card_model.dart';
import '../pages/card_format.dart';
import '../pages/profile.dart';
import '../pages/global.dart';


class PaymentCard extends StatefulWidget {
  const PaymentCard({Key? key}) : super(key: key);

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {




  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvcController = TextEditingController();
  final _nameController = TextEditingController();



  // Function to add a new card to the list
   _addCard() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final card = myCard(
        cardNumber: _cardNumberController.text,
        expiryDate: _expiryDateController.text,
        cvc: _cvcController.text,
        name: _nameController.text,
      );
      setState(() {
        cards.add(card);
      });
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext c) {
            return ProgressDialog(
              message: "Processing Please wait...",
            );
          });
      Navigator.pop(context);
    }
  }
  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvcController.dispose();
    super.dispose();
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
        title: Text("Payment", style: TextStyle(color: Colors.white),),
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
                    backgroundImage: NetworkImage(
                        'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png'),
                  );
                }
              },
            ),
          ),
        ],
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
                Text("Amount"
                  ,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.white),),
                SizedBox(height: 10,),
                Text("USD 15.00"
                  ,style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25,color: Colors.white),),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: 15, ),
                Container(
                    alignment: Alignment.topLeft,
                  child:  Text("Add Card", style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w900),),
                ),
                SizedBox(height: 5, ),
                   Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Colors.white,
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: TextFormField(
                         controller: _cardNumberController,
                         textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                         FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                          CardNumberInputFormatter(),
                        ],

                        decoration: InputDecoration(
                          //fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText: '0000 0000 0000 0000',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                         validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please enter a card number';
                         }
                         return null;
                       },
                       ),
                     ),
                   ),

                SizedBox(height: 15, ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            //fillColor: Colors.white,
                            border: InputBorder.none,
                            hintText: 'MM/YY',
                            hintStyle: TextStyle(color: Colors.grey),

                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an expiry date';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _cvcController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            //fillColor: Colors.white,
                            border: InputBorder.none,
                            hintText: 'CVC',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                            validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a CVC';
                                }
                                 return null;
                                },

                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15, ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _nameController,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        //fillColor: Colors.white,
                        border: InputBorder.none,
                        hintText: 'Name On Card',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },

                    ),
                  ),
                ),
                SizedBox(height: 15, ),
                GestureDetector(
                  onTap: () {

                  },
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.white60),
                    ),
                    tileColor: Color(0xff2b67db),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                    title: Text("Add Card",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),textAlign: TextAlign.center,),
                  ),
                ),

              ],
            ),
          ),

          SizedBox(height: 8,),
        ],
      ),


    );
  }
}
