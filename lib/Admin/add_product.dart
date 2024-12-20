import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  String? _base64Image;
  String? _selectedCategory;
  final List<String> categoryItems = [
    'iPhone', 'MacBook', 'iPad', 'Apple Watch', 'AirPods'
  ];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _base64Image = pickedFile.path;
      });
    }
  }

  Future<void> _addProduct() async {
    final name = _nameController.text.trim();
    final price = _priceController.text.trim();

    if (name.isEmpty || price.isEmpty || _base64Image == null || _selectedCategory == null) {
      Fluttertoast.showToast(msg: "Vui lòng điền đầy đủ thông tin");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('products').add({
        'name': name,
        'price': double.parse(price),
        'category': _selectedCategory,
        'image': _base64Image,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Fluttertoast.showToast(msg: "Thêm sản phẩm thành công!");
      Navigator.pop(context);
    } catch (e) {
      Fluttertoast.showToast(msg: "Lỗi khi thêm sản phẩm: $e");
    }
  }

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
            // Upload Image Section
            Text(
              "Upload the Product Image",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: _base64Image == null
                    ?Icon(Icons.add_a_photo_outlined, size: 50, color: Colors.grey,)
                      :ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(base64Decode(_base64Image!),
                    fit: BoxFit.cover, height: 150, width: 150,),
                  )
                ),
              ),
            ),

            SizedBox(height: 30),

            // Product Name Section
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
                decoration: InputDecoration(
                  hintText: "Enter product name",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),

            SizedBox(height: 30),

            // Product Category Section
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

            SizedBox(height: 40),

            // Add Product Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add product functionality
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
