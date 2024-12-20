import 'package:applestoreapp/pages/category_products.dart';
import 'package:applestoreapp/widget/support_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories=[
    "images/macpro.png",
    "images/ipadpro13.png",
    "images/iphone16prm.jpeg",
    "images/watchultra2.png",
    "images/airpods.jpeg",
  ];

  List Categoryname=[
    "Macbook",
    "iPad",
    "iPhone",
    "Apple Watch",
    "Airpods",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Container(
        margin: EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Good Morning, Duc", style: AppWidget.boldTextFieldStyle(),),
                    Text("Welcome to Apple Store", style: AppWidget.lightTextFieldStyle()),
                  ],
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset("images/macpro.png", height: 70, width: 70, fit: BoxFit.cover,)),
              ],
            ),
            SizedBox(height: 30,),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Products",
                  hintStyle: AppWidget.lightTextFieldStyle(),
                  prefixIcon: Icon(Icons.search, color: Colors.black54,),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories", style: AppWidget.semiboldTextFieldStyle()),
                Text("View All", style: AppWidget.blueTextFieldStyle()),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  height: 129,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Text("All", 
                        style: TextStyle(
                            color: Colors.white, 
                            fontSize: 20, 
                            fontWeight: FontWeight.bold),
                      ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 129,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          return CategoryTile(image: categories[index], name: Categoryname[index],);
                        }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("All Products", style: AppWidget.semiboldTextFieldStyle()),
                Text("View All", style: AppWidget.blueTextFieldStyle()),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              height: 220,
              padding: EdgeInsets.only(left: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // Product Card
                  Container(
                    width: 160,
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "images/macpro.png",
                            height: 120,
                            width: 120,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "MacBook Pro M4",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$999",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[700],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {

                                },
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.blueAccent,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "images/iphone16prm.jpeg",
                            height: 120,
                            width: 120,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "iPhone 16 Pro",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$999",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[700],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {

                                },
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.blueAccent,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "images/ipadpro13.png",
                            height: 120,
                            width: 120,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "iPad Pro 13 Inch",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$999",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[700],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {

                                },
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.blueAccent,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  String image, name;
  CategoryTile({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryProducts(category: name,)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(image, height: 60, width: 60, fit: BoxFit.cover,),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
