import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:luna/auth/google.dart';
import 'package:luna/helper/helper.dart';
import 'package:luna/widgets/loading.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bgColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(user!.displayName!.toString()),
            ),
            ElevatedButton(
              onPressed: () {
                Google google = Google();
                setState(() {
                  _isLoading = true;
                });
                google.handleLogOut();
                setState(() {
                  _isLoading = false;
                });
              },
              child: Text("Log Out"),
            ),
            _isLoading ? Loading() : Container()
          ],
        ),
      ),
    );
  }
}
