import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod{
  Future addUserDetails(Map<String,dynamic> userInfoMap, String id) async{
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  UpdateUserWallet(String id, String amount) async{
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({"Wallet" : amount});
  }

  Future addFoodItem(Map<String, dynamic> itemInfoMap, String name) async {
    return await FirebaseFirestore.instance
        .collection(name)
        .add(itemInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodItems(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();

  }

  Future addFoodItemtoCart(Map<String, dynamic> itemInfoMap,String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id).collection("cart")
        .add(itemInfoMap);
  }

  Future<Stream<QuerySnapshot>> getCartItems(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("cart")
        .snapshots();

  }

  deleteFoodItem(String userId, String cartItemId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(cartItemId)
        .delete();
  }



}