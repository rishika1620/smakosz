import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:smakosz/Screens/TermsAndConditionsPage.dart';
import 'package:smakosz/Screens/login.dart';
import 'package:smakosz/Services/auth.dart';
import 'package:smakosz/Services/shared_pref.dart';
import 'package:smakosz/Widgets/on_board.dart';
import 'package:smakosz/Widgets/widget_support.dart';

class User_Profile extends StatefulWidget {
  const User_Profile({super.key});

  @override
  State<User_Profile> createState() => _User_ProfileState();
}

class _User_ProfileState extends State<User_Profile> {

  String? profile, name, email;

  File? selectedImage;
  String? _imageUrl;

  Future getImageFromDevice() async{
    final ImagePicker _imagePicker = ImagePicker();
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {
      uploadItem();
    });
  }

  uploadItem() async {
    if(selectedImage!=null){
      final cloudinary = Cloudinary.signedConfig(
        apiKey: '514846678588132',
        apiSecret: 'BQZ2Y2BTVwI0-nMD8e4uMNC2iZs',
        cloudName: 'ddh84qxwx',
      );

      try {
        String id = randomAlphaNumeric(10);
        final response = await cloudinary.upload(
          file: selectedImage!.path,
          resourceType: CloudinaryResourceType.image,
          folder: 'public',
          fileName: id,
        );
        if (response.isSuccessful) {
          print("Upload successful: ${response.secureUrl}");
          _imageUrl = response.secureUrl;
        } else {
          print("Upload failed: ${response.error}");
        }
      } catch (e) {
        print("Error during upload: $e");
      }

      await SharedPreferenceHelper().saveUserProfile(_imageUrl!);
      setState(() {

      });
    }
  }

  getSharedPref() async {
    profile = await SharedPreferenceHelper().getUserProfile();
    name = await SharedPreferenceHelper().getUserName();
    email =await SharedPreferenceHelper().getUserEmail();
    setState(() {

    });
  }

  onthisLoad() async {
    await getSharedPref();
    setState(() {

    });
  }

  logout(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Logout", style: AppWidget.headLineTextFieldStyle(),),
        content: Text("Are you sure you want to logut?", style: TextStyle(
          fontSize: 15,
        ),),
        actions: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)
                    ),

                    child: Text("Cancel", style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),),
                  ),
                ),
              ),

              GestureDetector(
                onTap: (){
                  AuthMethods().SignOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)
                    ),

                    child: Text("Logout", style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),),
                  ),
                ),
              )
            ],
          ),

        ],
      );
    });
  }

  deleteAccount(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Delete Account", style: AppWidget.headLineTextFieldStyle(),),
        content: Text("Are you sure you want to delete Account?", style: TextStyle(
          fontSize: 15,
        ),),
        actions: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30)
                    ),

                    child: Text("Cancel", style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),),
                  ),
                ),
              ),

              GestureDetector(
                onTap: (){
                  AuthMethods().deleteUser();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoard()));
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text("Delete", style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),),
                  ),
                ),
              )
            ],
          ),

        ],
      );
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    onthisLoad();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: name == null? CircularProgressIndicator(
        color: Colors.black,
      ):Container(
        child: Column(
          children: [
            Stack(
              children: [
               Container(
                 padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
                 height: MediaQuery.of(context).size.height/4.3,
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                   color: Colors.black,
                   borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width, 105.0))
                 ),
               ) ,

                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/6.5),
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(60),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: selectedImage == null? GestureDetector(
                            onTap: (){
                              getImageFromDevice();
                            },
                            child: profile == null? Image.asset("assets/images/boy.png", height: 120, width: 120, fit: BoxFit.cover,):Image.network(profile!, height: 120,width: 120,fit: BoxFit.cover,)) : Image.file(selectedImage!, height: 120, width: 120,fit: BoxFit.cover,)
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 70.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(name!, style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),)
              ],
            ),

            SizedBox(height: 20.0,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.black,),
                      SizedBox(width: 20.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name", style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text(name!, style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.email_rounded, color: Colors.black,),
                      SizedBox(width: 20.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email", style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text(email!, style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.0,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionsPage()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.description, color: Colors.black,),
                        SizedBox(width: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Terms and Conditions", style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            GestureDetector(
              onTap: deleteAccount,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.black,),
                        SizedBox(width: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Delete Account", style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            GestureDetector(
              onTap: logout ,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.black,),
                        SizedBox(width: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Logout", style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        )
        ),
    );
  }
}
