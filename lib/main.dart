import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:luna/views/errorPage.dart';
import 'package:luna/views/welcome.dart';
import 'package:luna/widgets/loading.dart';
import 'package:luna/views/homePage.dart';

/*
TODO : 
{ 
  

  in sounds tab : 
  carasoul : random item from all songs
  all songs,
  big screen : play songs(actualling playing live),
              bottam sheet playing(like in spotify)
              
  in profile tab : display :
  image,name, application usage stats,you are feeling : ___ today (use shared pref. to store daily mood of person)
  
}

additional features : {
  noification playing,
  background playing
}








api end points : 
1. 'https://luna-50a55-default-rtdb.firebaseio.com/content.json?print=pretty' = for main page
2. 'https://luna-50a55-default-rtdb.firebaseio.com/all_sounds.json?print=pretty' = for all sounds page

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
