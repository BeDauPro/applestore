import 'package:applestoreapp/pages/Order.dart';
import 'package:applestoreapp/pages/home.dart';
import 'package:applestoreapp/pages/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  late List<Widget> pages;
  late Home HomePage;
  late Order order;
  late Profile profile;
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    HomePage = Home();
    order = Order();
    profile = Profile();
    pages = [HomePage, order, profile];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Color(0xfff2f2f2),
        color: Colors.black,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        index: currentTabIndex,
        items: [
          Icon(Icons.home, color: Colors.white,),
          Icon(Icons.list, color: Colors.white,),
          Icon(Icons.person, color: Colors.white,),
        ]
      ),
      body: pages[currentTabIndex],
    );
  }
}
