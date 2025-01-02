import 'package:applestoreapp/pages/category_products.dart';
import 'package:applestoreapp/pages/product_detail.dart';
import 'package:applestoreapp/services/database.dart';
import 'package:applestoreapp/services/share_pref.dart';
import 'package:applestoreapp/widget/support_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<DocumentSnapshot>> allProductsFuture;

  bool search = false;
  List<Map<String, String>> categories = [
    {"image": "images/macpro.png", "name": "Macbook"},
    {"image": "images/ipadpro13.png", "name": "iPad"},
    {"image": "images/iphone16prm.jpeg", "name": "iPhone"},
    {"image": "images/watchultra2.png", "name": "Apple Watch"},
    {"image": "images/airpods.jpeg", "name": "Airpods"},
  ];
  List<Map<String, String>> queryResultSet = [];

  String? name, image;

  initiateSearch(String value) {
    if (value.isEmpty) {
      setState(() {
        queryResultSet.clear();
      });
      return;
    }

    setState(() {
      search = true;
      queryResultSet = categories
          .where((category) =>
          category["name"]!.toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    });
  }


  getthesharedpref()async{
    name = await SharedPreferenceHelper().getUserName();
    image = await SharedPreferenceHelper().getUserImage();
    setState(() {});
  }


  ontheload()async{
    await getthesharedpref();
    setState(() {

    });
  }
  @override
  void initState(){
    ontheload();
    super.initState();
    allProductsFuture = DatabaseMethods().getAllProductsFromCategories([
      'iPhone',
      'iPad',
      'Macbook',
      'Airpods',
      'Apple Watch',
    ]);
  }

  Widget buildProductGrid(List<DocumentSnapshot> productList) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        DocumentSnapshot product = productList[index];
        return Container(
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product["Image"],
                  height: 120,
                  width: 120,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  product["Name"],
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
                      "\$${product["Price"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetail(
                              name: product["Name"],
                              price: product["Price"],
                              image: product["Image"],
                              detail: product["Detail"],
                            ),
                          ),
                        );
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
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: name== null? Center(child: CircularProgressIndicator()):Container(
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
                    Text("Hello, " + name!, style: AppWidget.boldTextFieldStyle(),),
                    Text("Welcome to Apple Store", style: AppWidget.lightTextFieldStyle()),
                  ],
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(image!, height: 70, width: 70, fit: BoxFit.cover,)),
              ],
            ),
            SizedBox(height: 30,),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                onChanged: (value){
                  initiateSearch(value);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Products",
                  hintStyle: AppWidget.lightTextFieldStyle(),
                  prefixIcon: Icon(Icons.search, color: Colors.black54,),
                ),
              ),
            ),
            SizedBox(height: 20,),
            search
                ? queryResultSet.isEmpty
                ? const Text("No results found.")
                : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              primary: false,
              shrinkWrap: true,
              children: queryResultSet.map((product) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                    AssetImage(product["image"]!),
                  ),
                  title: Text(product["name"]!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryProducts(
                            category: product["name"]!),
                      ),
                    );
                  },
                );
              }).toList(),
            ):Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories", style: AppWidget.semiboldTextFieldStyle()),
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
                  child: SizedBox(
                    height: 129,
                    child: ListView.builder(
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          image: categories[index]["image"]!,
                          name: categories[index]["name"]!,
                        );
                      },
                    ),
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
              height: 415,
              padding: EdgeInsets.only(left: 10),
              child: FutureBuilder<List<DocumentSnapshot>>(
                future: allProductsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error loading products: ${snapshot.error}"),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text("No products found."),
                    );
                  } else {
                    return buildProductGrid(snapshot.data!);
                  }
                },
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
