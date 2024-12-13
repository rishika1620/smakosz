import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smakosz/Services/database.dart';
import 'package:smakosz/Services/shared_pref.dart';
import 'package:smakosz/Widgets/app_constant.dart';
import 'package:smakosz/Widgets/widget_support.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {

  String? wallet, id;
  int? add;
  TextEditingController _amountController = new TextEditingController();

  getSharedPref() async{
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {
    });
  }

  ontheload() async{
    await getSharedPref();
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    ontheload();
    super.initState();
  }

  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet == null? CircularProgressIndicator(): Container(
        margin: EdgeInsets.only(top: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0),
                  child: Center(child: Text("Wallet", style: AppWidget.headLineTextFieldStyle(),)),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFF2F2F2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/images/wallet.png", height: 60, width: 60, fit: BoxFit.cover,),
                      SizedBox(width: 40.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Your Wallet", style: AppWidget.semiBoldTextFieldStyle(),),
                          SizedBox(height: 5.0,),
                          Text("₹" + "${wallet}", style: AppWidget.boldTextFieldStyle(),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("Add Money", style: AppWidget.semiBoldTextFieldStyle(),),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    makePayment('100');
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        border: Border.all(
                          color: Colors.black,),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("₹" + "100", style: AppWidget.semiBoldTextFieldStyle(),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    makePayment('500');
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        border: Border.all(
                          color: Colors.black,),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("₹" + "500", style: AppWidget.semiBoldTextFieldStyle(),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    makePayment('1000');
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        border: Border.all(
                          color: Colors.black,),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("₹" + "1000", style: AppWidget.semiBoldTextFieldStyle(),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    makePayment('2000');
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(

                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        border: Border.all(
                          color: Colors.black,),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("₹" + "2000", style: AppWidget.semiBoldTextFieldStyle(),),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0,),
            GestureDetector(
              onTap: (){
                openEdit();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.symmetric(vertical: 12.0,),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text("Add Money", style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ) ,)),
              ),
            )

          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String amount) async{
    try{
      paymentIntent = await createPaymentIntent(amount, "INR");
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent!['client_secret'],
        style: ThemeMode.dark,
        merchantDisplayName: 'Adnan' ,
      )).then((value) {});

      displayPaymentSheet(amount);
    }catch(e,s){
      print('exception: $e$s');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        add = int.parse(wallet!) + int.parse(amount);
        await SharedPreferenceHelper().saveUserWallet(add.toString());
        await DatabaseMethod().UpdateUserWallet(id!, add.toString());
        showDialog(context: context, builder: (_) =>
            AlertDialog(
              content: Container(
                child:
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green,),
                      Text("Payment Successful"),
                    ],
                  )
              ),
            ));
        await getSharedPref();
        paymentIntent = null;

      }).onError((error, stackTrace) {
        print("Error is: --> $error $stackTrace");
      });
    } on StripeException catch(e){
      print("Error is: -> $e");
      showDialog(context: context, builder: (_) => const AlertDialog(
        content: Text("Cancelled"),
      ) );
    }catch(e){
      print('$e');
    }
  }




  createPaymentIntent(String amount, String currency) async{
    try{
      Map<String, dynamic> body = {
        'amount' : calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]' : 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization' : 'Bearer $secret_key',
          'Content-Type' : 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print('Payment Intent Body-->> ${response.body.toString()}');
      return jsonDecode(response.body);
    }catch(err){
      print('error charging user ${err.toString()}');
    }
  }

  calculateAmount(String amount){
    final calculatedAmount = int.parse(amount)*100.toInt();
    return calculatedAmount.toString();
  }

  Future openEdit()=> showDialog(context: context, builder: (context) => AlertDialog(
    content: Container(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.cancel),
              ),
              SizedBox(width: 60,),
              Center(
                child: Text("Add Money", style: TextStyle(
                  color: Color(0xFF008080),
                  fontWeight: FontWeight.bold
                ),),
              )
            ],
          ),

          SizedBox(height: 20,),
          Text("Amount"),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _amountController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Amount'
              ),
            ),
          ),

          SizedBox(height: 20.0,),

          Center(
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
                makePayment(_amountController.text);
              },
              child: Container(
                width: 100,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF008080),
                ),
                child: Center(
                  child: Text("Pay", style: TextStyle(
                    color: Colors.white,
                  ),),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  ));
}
