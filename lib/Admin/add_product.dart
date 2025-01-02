import 'dart:convert';
import 'package:applestoreapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
  final _detailController = TextEditingController();
  String? _selectedCategory;
  final List<String> categoryItems = [
    'iPhone', 'MacBook', 'iPad', 'Apple Watch', 'Airpods'
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: Text(
          "Add Product",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Product Name",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Enter product name",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Image link",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _imageController,
                decoration: InputDecoration(
                  hintText: "Enter product image link",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Product Price",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  hintText: "Enter product price",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Product Category",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  items: categoryItems
                      .map(
                        (item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  dropdownColor: Colors.white,
                  value: _selectedCategory,
                  hint: Text(
                    "Select category",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Product Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _detailController,
                decoration: InputDecoration(
                  hintText: "Enter product details",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 80),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_nameController.text.isEmpty ||
                      _priceController.text.isEmpty ||
                      _imageController.text.isEmpty ||
                      _detailController.text.isEmpty ||
                      _selectedCategory == null) {
                    Fluttertoast.showToast(
                      msg: "Please fill in all fields",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                    return;
                  }

                  Map<String, dynamic> userInfoMap = {
                    "Name": _nameController.text,
                    "Price": _priceController.text,
                    "Image": _imageController.text,
                    "Detail": _detailController.text,
                  };

                  try {
                    await DatabaseMethods().addProduct(userInfoMap, _selectedCategory!);
                    Fluttertoast.showToast(
                      msg: "Product added successfully!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );

                    _nameController.clear();
                    _priceController.clear();
                    _imageController.clear();
                    _detailController.clear();
                    setState(() {
                      _selectedCategory = null;
                    });
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: "Failed to add product: $e",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Add Product",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
