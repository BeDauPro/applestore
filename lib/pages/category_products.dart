import 'package:applestoreapp/pages/product_detail.dart';
import 'package:applestoreapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryProducts extends StatefulWidget {
  String category;
  CategoryProducts({required this.category});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  Stream? CategoryStream;

  getontheload() async{
   CategoryStream = await DatabaseMethods().getProducts(widget.category);
   setState(() {

   });
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allProduct(){
    return StreamBuilder(stream: CategoryStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData? GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.6, mainAxisSpacing: 10, crossAxisSpacing: 10),itemCount: snapshot.data.docs.length, itemBuilder: (context, index){
            DocumentSnapshot ds = snapshot.data.docs[index];
            return Container(
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
                    child: Image.network(
                      ds["Image"],
                      height: 120,
                      width: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      ds["Name"],
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
                          "\$"+ds["Price"],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(name: ds["Name"], price: ds["Price"], image: ds["Image"], detail: ds["Detail"])));
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
          }): Container();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: [
            Expanded(child: allProduct())
          ],
        ),
      ),
    );
  }
}
