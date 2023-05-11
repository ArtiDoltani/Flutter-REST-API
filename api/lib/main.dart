import 'package:api/Example_four.dart';
import 'package:api/LastExample.dart';
import 'package:api/Screens/SignUp.dart';
import 'package:api/Screens/uploadimage.dart';
import 'package:api/example_two.dart';
import 'package:api/homeScreen.dart';
import 'package:api/user_Example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UploadimageScreen()
        // SignUp()

        //Get APIS
        //LastExample()
        //ExampleFour()
        // UserExample()
        //ExampleTwo()
        // HomeScreen(),
        );
  }
}
