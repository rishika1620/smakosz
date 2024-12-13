import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smakosz/Screens/forgot_password.dart';
import 'package:smakosz/Screens/sign_up.dart';
import 'package:smakosz/Widgets/bottom_nav.dart';
import 'package:smakosz/Widgets/widget_support.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email = "", password= "";

  final _formkey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  userLogin() async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav()));
    } on FirebaseException catch(e){
      if(e.code == "user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("User doesn't exists",
                  style: TextStyle(
                    fontSize: 16,
                  ),)));
      } else if(e.code == "wrong-password"){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Incorrect password",
                  style: TextStyle(
                    fontSize: 16,
                  ),)));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                  ])
                ),
                
              ),
        
              Container(
                margin: EdgeInsets.only(top:  MediaQuery.of(context).size.height/3),
                height: MediaQuery.of(context).size.height/1.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                ),
                child: Text(""),
              ),
              Container(
                margin: EdgeInsets.only(top: 60, left: 20, right: 20 ),
                child: Column(
                  children: [
                    Center(child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset("assets/images/logo.png", width: MediaQuery.of(context).size.width/1.5, fit: BoxFit.cover,))),
                    SizedBox(height: 50,),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,) ,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Center(child: Text("Login ", style: AppWidget.headLineTextFieldStyle(),)),
                              SizedBox(height: 40,),
                              TextFormField(
                                controller: _emailController,
                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return "Please entre your email";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  prefixIcon: Icon(Icons.email, size: 20,),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                                      borderSide: BorderSide(
                                        color: Colors.grey, // Border color
                                        width: 2.0,        // Border width
                                      ),
                                  ),
                                  focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                                    borderSide: BorderSide(
                                      color: Colors.black, // Border color
                                      width: 2.0,        // Border width
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              TextFormField(
                                controller: _passwordController,
                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return "Please entre your password";
                                  }
                                  return null;
                                },
                                obscureText: true ,
                                decoration: InputDecoration(
                                  hintText: "Enter Password",
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  prefixIcon: Icon(Icons.lock, size: 20,),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                                    borderSide: BorderSide(
                                      color: Colors.grey, // Border color
                                      width: 2.0,        // Border width
                                    ),
                                  ),
                                  focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                                    borderSide: BorderSide(
                                      color: Colors.black, // Border color
                                      width: 2.0,        // Border width
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),

                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                                },
                                child: Container(
                                    alignment: Alignment.topRight,
                                    child: Text("Forgot Password?", style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blueAccent
                                    ),)),
                              ),
                              SizedBox(height: 60,),
                              GestureDetector(
                                onTap: (){
                                  if(_formkey.currentState!.validate()){
                                    setState(() {
                                      email = _emailController.text;
                                      password = _passwordController.text;
                                    });
                                  }
                                  userLogin();
                                },
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(child: Text("LOGIN", style:  TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),)),
                                  ),
                                ),
                              ),
                              ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 70,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text("Don't have an account? Sign up", style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.blueAccent,
                      ),),
                    )
        
                  ],
        
        
                ),
        
              )
            ],
          ),
        ),
      ),
    );
  }
}
