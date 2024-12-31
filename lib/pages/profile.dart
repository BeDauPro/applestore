import 'package:applestoreapp/pages/onboarding.dart';
import 'package:applestoreapp/services/auth.dart';
import 'package:applestoreapp/widget/support_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/share_pref.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? image, name, email;

  getthesharedpref() async {
    image = await SharedPreferenceHelper().getUserImage();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {}); // Update the UI after fetching data
  }

  @override
  void initState() {
    getthesharedpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'SF Pro',
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: CupertinoColors.systemGroupedBackground,
      body: name == null
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(image!),
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileInfoTile(
              context,
              icon: CupertinoIcons.person,
              title: "Name",
              value: name!,
            ),
            const SizedBox(height: 10),
            _buildProfileInfoTile(
              context,
              icon: CupertinoIcons.mail,
              title: "Email",
              value: email!,
            ),
            const SizedBox(height: 10),
            _buildLogoutTile(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoTile(BuildContext context,
      {required IconData icon, required String title, required String value}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey4.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: CupertinoColors.activeBlue, size: 28),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                  fontFamily: 'SF Pro',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'SF Pro',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutTile(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        await AuthMethods().SignOut().then((value){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Onboarding(),));
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey4.withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(CupertinoIcons.square_arrow_right,
                color: CupertinoColors.destructiveRed, size: 28),
            const SizedBox(width: 16),
            Text(
              "Logout",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.destructiveRed,
                fontFamily: 'SF Pro',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
