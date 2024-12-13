import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:smakosz/Services/database.dart';
import 'package:smakosz/Widgets/widget_support.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary/cloudinary.dart';
class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {

  final List<String> items = ['Burger', 'Ice-cream', 'Pizza', 'Salad'];
  String? value;
  TextEditingController _itemNameController = new TextEditingController();
  TextEditingController _itemPriceController = new TextEditingController();
  TextEditingController _itemDetailsController = new TextEditingController();

  File? selectedImage;
  String? _imageUrl;

  Future getImageFromDevice() async{
    final ImagePicker _imagePicker = ImagePicker();
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {

    });
  }

  uploadItem() async {
    if(selectedImage!=null && _itemNameController.text != "" && _itemPriceController.text != "" && _itemDetailsController.text!=""){
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

     Map<String, dynamic> addItem = {
        "Image" : _imageUrl,
        "Name" : _itemNameController.text,
        "Price" : _itemPriceController.text,
        "Detail" : _itemDetailsController.text,
      };

      await DatabaseMethod().addFoodItem(addItem, value!).then((value){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
            content: Text("Item has been added Successfully!", style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),),

        ));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xFF373866),)),
            centerTitle: true,
        title: Text("Add Item", style: AppWidget.headLineTextFieldStyle(),),

      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload the Item Picture", style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 20.0,),
               selectedImage == null? GestureDetector(
                 onTap: (){
                   getImageFromDevice();
                 },
                 child: Center(
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                          width: 1.5
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.camera_alt_outlined, color: Colors.grey,),
                    ),
                  ),
                               ),
               ) : Center(
                 child: Material(
                   elevation: 4.0,
                   borderRadius: BorderRadius.circular(20),
                   child: Container(
                     width: 150,
                     height: 150,
                     decoration: BoxDecoration(
                       border: Border.all(
                           color: Colors.black38,
                           width: 1.5
                       ),
                       borderRadius: BorderRadius.circular(20),
                     ),
                     child: ClipRect(
                       child: Image.file(
                         selectedImage!,
                         fit: BoxFit.cover,
                       ),
                     ),
                   ),
                 ),
               ),
              SizedBox(height: 30.0,),
              Text("Item Name", style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 30.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _itemNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Name",
                    hintStyle: AppWidget.lightTextFieldStyle(),
                  ),
                ),
              ),
        
              SizedBox(height: 30.0,),
              Text("Item Price", style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 30.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _itemPriceController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Price",
                    hintStyle: AppWidget.lightTextFieldStyle(),
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              Text("Item Details", style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 30.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  maxLines: 6,
                  controller: _itemDetailsController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Details",
                    hintStyle: AppWidget.lightTextFieldStyle(),
                  ),
                ),
              ),

              SizedBox(height: 20.0,),
              Text("Select Category", style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 20.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFececf8),
                ),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<String> (
                      items: items.map((item)=> DropdownMenuItem<String>(
                        value: item,
                          child: Text(item, style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),))).toList(),
                      onChanged: ((value) => setState(() {
                        this.value = value;
                      })),
                      dropdownColor: Colors.white,
                      hint: Text("Select Category"),
                      iconSize: 36,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
                      value: value,
        
                    )),
              ),
              
              SizedBox(height: 30.0,),
              GestureDetector(
                onTap: (){
                  uploadItem();
                },
                child: Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text("Add", style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
