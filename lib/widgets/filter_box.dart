import 'package:flutter/material.dart';

class CustomFilterBox extends StatelessWidget {
  const CustomFilterBox({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 60,
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10)
      ),
      child: IconButton(
              icon: Icon(Icons.filter_list),
              color: Colors.blue,
              iconSize: 30,
              onPressed: () {
              },
            ),


    );
  }
}