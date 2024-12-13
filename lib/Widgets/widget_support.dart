import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget{
  static TextStyle boldTextFieldStyle(){
    return GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static headLineTextFieldStyle(){
    return GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    );
  }

  static lightTextFieldStyle(){
    return GoogleFonts.poppins(
      color: Colors.black38,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
  }

  static semiBoldTextFieldStyle(){
    return GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
  }


}