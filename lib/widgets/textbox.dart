import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 260,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10)
        ),
        child: TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: IconButton(
              icon: Icon(Icons.search_outlined),
              color: Colors.blue,
              iconSize: 30,
              onPressed: () {
              },
            ),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 17)),
        ),
      );
  }
}