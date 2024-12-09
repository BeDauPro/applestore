import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Apple Store", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 180),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("images/appledevices.jpeg"),
          Center(
              child: Text("The new Apple generation\nHello, Apple Intelligence",
                style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(height: 180,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(60)),
                child: Text("Next",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),),
    );
  }
}