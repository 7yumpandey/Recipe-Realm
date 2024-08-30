import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_recipe/Signin/reuseableWidget.dart';

class IntroHome extends StatefulWidget {
  const IntroHome({super.key});

  @override
  State<IntroHome> createState() => _IntroHomeState();
}

class _IntroHomeState extends State<IntroHome> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 229, 221, 1),
      body:
        Center(
          child: Container(        
          padding: EdgeInsets.all(18.0),
          margin: EdgeInsets.fromLTRB(20, 60, 20, 140),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.black
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                logoWidget("assets/images/CheefRecipe.jpeg"),
              ],
            ),
          ),
            ),
        ),);
  }
}