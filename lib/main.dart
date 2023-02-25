import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home_screenone.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'view/Login/sign_in.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final storage = FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for Errors
          if (snapshot.hasError) {
            print("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return MaterialApp(
              title: 'Flutter Firebase EMail Password Auth',
              theme: ThemeData(
                primarySwatch: Colors.deepPurple,
              ),
              debugShowCheckedModeBanner: false,
              home: FutureBuilder(
                future: checkLoginStatus(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.data == false) {
                    return Login();
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ShowImages();
                },
              ));
        });
    //  MaterialApp(
    //     title: 'Flutter Demo',
    //     theme: ThemeData(
    //       // This is the theme of your application.
    //       //
    //       // Try running your application with "flutter run". You'll see the
    //       // application has a blue toolbar. Then, without quitting the app, try
    //       // changing the primarySwatch below to Colors.green and then invoke
    //       // "hot reload" (press "r" in the console where you ran "flutter run",
    //       // or simply save your changes to "hot reload" in a Flutter IDE).
    //       // Notice that the counter didn't reset back to zero; the application
    //       // is not restarted.
    //       primarySwatch: Colors.blue,
    //     ),
    //     home: Login());
  }
}
