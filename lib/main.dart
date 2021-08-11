import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:luna/views/welcome.dart';
import 'package:luna/widgets/splashLoading.dart';

// TODO : Clip size of logo
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(MyApp());
}

class Init {
  Init._();
  static final instance = Init._();
  Future initialize() async {
    await Future.delayed(Duration(seconds: 3));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: SplashLoading(),
            debugShowCheckedModeBanner: false,
          );
        } else {
          // Loading is done, return the app:
          return MaterialApp(
              home: WelComeScreen(), debugShowCheckedModeBanner: false);
        }
      },
    );
  }
}
