import 'package:applestoreapp/Admin/add_product.dart';
import 'package:applestoreapp/Admin/admin_login.dart';
import 'package:applestoreapp/Admin/all_orders.dart';
import 'package:applestoreapp/Admin/home_admin.dart';
import 'package:applestoreapp/pages/bottomnav.dart';
import 'package:applestoreapp/pages/home.dart';
import 'package:applestoreapp/pages/login.dart';
import 'package:applestoreapp/pages/onboarding.dart';
import 'package:applestoreapp/pages/product_detail.dart';
import 'package:applestoreapp/pages/signup.dart';
import 'package:applestoreapp/services/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  Stripe.publishableKey = publishableKey;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Onboarding(),
    );
  }
}
