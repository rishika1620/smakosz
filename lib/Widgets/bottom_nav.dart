import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:smakosz/Screens/home.dart';
import 'package:smakosz/Screens/orders.dart';
import 'package:smakosz/Screens/user_profile.dart';
import 'package:smakosz/Screens/wallet.dart';
class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTableIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late Home homePage;
  late Wallet walletPage;
  late Orders ordersPage;
  late User_Profile user_profilePage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePage = Home();
    walletPage = Wallet();
    ordersPage = Orders();
    user_profilePage =User_Profile();

    pages = [homePage, ordersPage, walletPage, user_profilePage];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  CurvedNavigationBar(
          height: 65,
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index){
            setState(() {
              currentTableIndex = index;
            });
          },
          items: [
        Icon(Icons.home_outlined, color: Colors.white,),
        Icon(Icons.shopping_bag_outlined, color: Colors.white,),
        Icon(Icons.wallet_outlined, color: Colors.white,),
        Icon(Icons.person_outlined, color: Colors.white,),

      ]),

      body: pages[currentTableIndex] ,
    );
  }
}
