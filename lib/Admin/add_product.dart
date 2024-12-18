import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? selectedCategory;
  final List<String> categoryItems = [
    'iPhone', 'MacBook', 'iPad', 'Apple Watch', 'AirPods'
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
                onTap: () {
                  // Add image upload functionality
                },
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
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.grey[600],
                    size: 50,
                  ),
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
                      selectedCategory = value;
                    });
                  },
                  dropdownColor: Colors.white,
                  value: selectedCategory,
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
