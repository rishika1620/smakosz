import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:smakosz/Screens/home.dart';
import 'package:smakosz/Widgets/app_constant.dart';
import 'package:smakosz/Widgets/on_board.dart';
import 'package:smakosz/admin/admin_login.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishable_key;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Smakosz",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

      ),
      home: OnBoard(),
    );
  }
}
