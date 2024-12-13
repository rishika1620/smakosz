import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smakosz/Screens/sign_up.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  String email ="";
  TextEditingController _emailController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  resetPassword() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Password Reset email has been sent! ", style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),),
      ));
    } on FirebaseException catch(e){
      if(e.code == "user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("User doesn't exists! Create new account", style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),),
        ));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 70,),
            Container(
              alignment: Alignment.topCenter,
              child: Text("Password Recovery", style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),),
            ),

            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              padding: EdgeInsets.only(left: 20, bottom: 10),
              alignment: Alignment.topLeft,
              child: Text("Enter your email", style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            ),
            
            Expanded(
                child: Form(
                  key: _formkey,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, ),
                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            padding: EdgeInsets.only(left: 10) ,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextFormField(
                              controller: _emailController,
                              validator: (value){
                                if(value ==null ||value.isEmpty){
                                  return "Please enter email";
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),

                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                prefixIcon: Icon(
                                    Icons.email_rounded,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          SizedBox(height: 40.0,),
                                GestureDetector(
                                  onTap: (){
                                    if(_formkey.currentState!.validate()){
                                      setState(() {
                                        email = _emailController.text;
                                      });
                                    }
                                    resetPassword();
                                  },
                                  child: Container(
                                    width: 140,
                                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text("Send Email", style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 50,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?", style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),),
                              SizedBox(width: 5,),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                                },
                                child: Text("Create", style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.orange,
                                ),),
                              ),

                            ],
                          )
                              ],
                            ),
                      ),
                    ),
                ),
            SizedBox(height: 50,),

          ],
        ),
      ),
    );
  }
}
