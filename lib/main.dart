import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:luna/views/errorPage.dart';
import 'package:luna/views/welcome.dart';
import 'package:luna/widgets/loading.dart';
import 'package:luna/views/homePage.dart';

/*
TODO : 1. remove side menu icon , thus it will look like
logo           account

in profile tab : display :
image,name, application usage stats,you are feeling : ___ today (use shared pref. to store daily mood of person)

in sounds tab : 
carasoul : random item from all songs
all songs

in home : 
1. how are you feeling today 
2. different heading and five songs


*/
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
              return HomePage();
            }
            return WelComeScreen();
          },
        ),
        debugShowCheckedModeBanner: false);
  }
}
