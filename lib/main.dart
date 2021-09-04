import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:luna/widgets/loading.dart';

import 'pages/errorPage.dart';
import 'pages/homePage.dart';
import 'pages/welcome.dart';

/*
TODO : 
{ 
  FIRST TASK : playing music.......    

  
}

additional features : {

  noification playing,
  background playing
}
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  ));
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Loading();
            else if (snapshot.hasError) {
              return ErrorPage();
            } else if (snapshot.hasData) {
              return HomePage();
            }
            return WelComeScreen();
          },
        ),
        debugShowCheckedModeBanner: false);
  }
}
