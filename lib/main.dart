import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:luna/views/errorPage.dart';
import 'package:luna/views/welcome.dart';
import 'package:luna/widgets/loading.dart';
import 'package:luna/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
              return Home();
            }
            return WelComeScreen();
          },
        ),
        debugShowCheckedModeBanner: false);
  }
}
