import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:smakosz/Screens/home.dart';
import 'package:smakosz/Screens/login.dart';
import 'package:smakosz/Services/database.dart';
import 'package:smakosz/Services/shared_pref.dart';

import '../Widgets/widget_support.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String email = "", password="", username="";

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  final formkey = GlobalKey<FormState>();

  registration() async{
    if(password != null){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.black,
          content: Text("Registered Successfully! ", style: TextStyle(
          fontSize: 16,
            color: Colors.white,
        ),),)));

        String id = randomAlphaNumeric(10);
        Map<String, dynamic> addUserInfo = {
          "Name" : _nameController.text,
          "email": _emailController.text,
          "Wallet": '0',
          "Id" : id,
        };
        await DatabaseMethod().addUserDetails(addUserInfo, id);
        await SharedPreferenceHelper().saveUserId(id);
        await SharedPreferenceHelper().saveUserName(_nameController.text);
        await SharedPreferenceHelper().saveUserEmail(_emailController.text);
        await SharedPreferenceHelper().saveUserWallet('0');
        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
        
      } on FirebaseException catch(e){
        if(e.code == 'weak-password'){
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: Colors.black,
            content: Text("Password is too weak ", style: TextStyle(
            fontSize: 16,

          ),),)));
        }
        else if(e.code == 'email-already-in-use'){
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: Color(0xFFF2DDAC),
            content: Text("Account already exists", style: TextStyle(
            fontSize: 16,

          ),),)));
        }
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
                          Colors.grey, Colors.white10,
                        ])
                ),

              ),

              Container(
                margin: EdgeInsets.only(top:  MediaQuery.of(context).size.height/3),
                height: MediaQuery.of(context).size.height/1.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white70,
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
                        child: Image.asset("assets/images/logo.png", width: MediaQuery.of(context).size.width/1, fit: BoxFit.cover,))),
                    SizedBox(height: 50,),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,) ,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/1.75,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Form(
                          key: formkey,
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Center(child: Text("Sign Up", style: AppWidget.headLineTextFieldStyle(),)),
                              SizedBox(height: 40,),
                              TextFormField(
                                controller: _nameController,
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return 'Please enter Username';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  prefixIcon: Icon(Icons.person, size: 20,),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                                    borderSide: BorderSide(
                                      color: Color(0xFFF2DDAC), // Border color
                                      width: 2.0,        // Border width
                                    ),
                                  ),
                                  focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                                    borderSide: BorderSide(
                                      color: Color(0xFFF2DDAC), // Border color
                                      width: 2.0,        // Border width
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              TextFormField(
                                controller: _emailController,
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return 'Please enter Email';
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
                                      color: Color(0xFFF2DDAC), // Border color
                                      width: 2.0,        // Border width
                                    ),
                                  ),
                                  focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                                    borderSide: BorderSide(
                                      color: Color(0xFFF2DDAC), // Border color
                                      width: 2.0,        // Border width
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              TextFormField(
                                controller: _passwordController,
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return 'Please enter Password';
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
                                      color: Color(0xFFF2DDAC), // Border color
                                      width: 2.0,        // Border width
                                    ),
                                  ),
                                  focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                                    borderSide: BorderSide(
                                      color: Color(0xFFF2DDAC), // Border color
                                      width: 2.0,        // Border width
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 60,),
                              GestureDetector(
                                onTap: (){
                                  if(formkey.currentState!.validate()){
                                    setState(() {
                                      username = _nameController.text;
                                      email = _emailController.text;
                                      password = _passwordController.text;
                                    });
                                  }
                                  registration();
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
                                    child: Center(child: Text("SIGN UP", style:  TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text("Already have an account? Login", style: TextStyle(
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
