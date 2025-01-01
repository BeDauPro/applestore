import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async{
    return await FirebaseFirestore.instance.collection('users').doc(id).set(userInfoMap);
  }
  Future <Stream<QuerySnapshot>> getProducts(String category) async{
    return await FirebaseFirestore.instance.collection(category).snapshots();
  }

  Future <Stream<QuerySnapshot>> allOrders() async{
    return await FirebaseFirestore.instance.collection("Orders").where("Status", isEqualTo: "On The Way").snapshots();
  }

  Future addProduct(Map<String, dynamic> userInfoMap, String categoryName) async {
    if (categoryName.isEmpty) {
      throw Exception('Category name cannot be empty');
    }
    try {
      await FirebaseFirestore.instance.collection(categoryName).add(userInfoMap);
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }


  Stream<QuerySnapshot> getOrders(String email) {
    try {
      return FirebaseFirestore.instance
          .collection('Orders')
          .where('Email', isEqualTo: email)
          .snapshots();
    } catch (e) {
      print("Error fetching orders: $e");
      return Stream.empty();
    }
  }

  Future orderDetails(Map<String, dynamic> userInfoMap) async{
    return await FirebaseFirestore.instance.collection('Orders').add(userInfoMap);
  }

  updateStatus(String id) async{
    return await FirebaseFirestore.instance
        .collection("Orders").doc(id)
        .update({"Status": "Delivered"});
  }
}