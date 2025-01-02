import 'dart:convert';

import 'package:applestoreapp/services/constant.dart';
import 'package:applestoreapp/services/database.dart';
import 'package:applestoreapp/services/share_pref.dart';
import 'package:applestoreapp/widget/support_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatefulWidget {
  String name, price, image, detail;
  ProductDetail({required this.name, required this.price, required this.image, required this.detail});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

  class _ProductDetailState extends State<ProductDetail> {
    String? name,email, image;

    getthesharedpref( ) async {
      name = await SharedPreferenceHelper().getUserName();
      email = await SharedPreferenceHelper().getUserEmail();
      image = await SharedPreferenceHelper().getUserImage();
      setState(() {});
    }
  ontheload()async{
      await getthesharedpref();
      setState(() {

      });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ontheload();
  }
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 80, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(child: Image.network(widget.image, height: 400,)),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios, size: 30,)),
              ],),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20),
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),

                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.name,
                          style: AppWidget.boldTextFieldStyle(),),
                        Text("\$" + widget.price,
                            style: AppWidget.lightTextFieldStyle()
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text("Details", style: AppWidget.semiboldTextFieldStyle(),),
                    SizedBox(height: 10,),
                    Text(widget.detail),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  makePayment(widget.price);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');
      if (paymentIntent == null || !paymentIntent!.containsKey('client_secret')) {
        throw Exception("Failed to create Payment Intent. Check Stripe server response.");
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent?['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Flutter Stripe Store',
        ),
      );

      displayPaymentSheet();
    } catch (e, s) {
      print('Exception: $e');
      print('Stack Trace: $s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        Map<String,dynamic> orderInfoMap = {
          "Product": widget.name,
          "Price": widget.price,
          "Name:": name,
          "Email": email,
          "Image": image,
          "ProductImage": widget.image,
          "Status": "On The Way",
        };
        await DatabaseMethods().orderDetails(orderInfoMap);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.green),
                    Text("Paid Successfully"),
                  ],
                ),
              ],
            ),
          ),
        );
        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET: $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET: $e');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text("Payment Cancelled"),
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to create payment intent: ${response.body}");
      }

      return jsonDecode(response.body);
    } catch (err) {
      print('Error charging user: ${err.toString()}');
      rethrow;
    }
  }
  calculateAmount(String amount) {
    if (int.tryParse(amount) == null) {
      throw Exception("Invalid amount: $amount");
    }
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
}

