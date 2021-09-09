import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:luna/auth/google.dart';
import 'package:luna/helper/helper.dart';
import 'package:luna/widgets/loading.dart';
import 'package:luna/widgets/logo.dart';

class WelComeScreen extends StatefulWidget {
  const WelComeScreen({Key? key}) : super(key: key);

  @override
  _WelComeScreenState createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelComeScreen> {
  double _width = 0.0;
  bool _isGettingStarted = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg/bg1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: _width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Logo(
                size: _width * 0.9,
              ),
              welcomeText(),
              SizedBox(
                height: _width * 0.5,
              ),
              _isLoading
                  ? Loading()
                  : (_isGettingStarted ? getStarted() : loginWithGoogle()),
            ],
          ),
        ),
      ),
    );
  }

  Widget welcomeText() {
    return Container(
        child: Column(
      children: [
        Text(
          "WELCOME",
          style: TextStyle(
              color: Colors.white,
              fontFamily: MyFont.alegreyaBold,
              fontSize: _width * 0.08),
        ),
        Text(
          "Do meditation.Stay focused.",
          style: TextStyle(
              color: Colors.white,
              fontFamily: MyFont.alegreyaSansMedium,
              fontSize: _width * 0.05),
        ),
        Text(
          "Live a healthy life.",
          style: TextStyle(
              color: Colors.white,
              fontFamily: MyFont.alegreyaSansMedium,
              fontSize: _width * 0.05),
        )
      ],
    ));
  }

  Widget getStarted() {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isGettingStarted = false;
          });
        },
        child: Text(
          "Get Started",
          style: TextStyle(
            fontSize: _width * 0.07,
            color: Colors.white,
            fontFamily: MyFont.alegreyaSansMedium,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: MyColor.green,
          fixedSize: Size(_width * 0.8, _width * 0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget loginWithGoogle() {
    return Container(
      child: ElevatedButton(
        onPressed: () async {
          Google google = Google();
          setState(() {
            _isLoading = true;
          });
          await google.handleLogIn();
          setState(() {
            _isLoading = false;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.login_rounded,
              size: _width * 0.08,
            ),
            Text(
              "Login With Google",
              style: TextStyle(
                fontSize: _width * 0.07,
                color: Colors.white,
                fontFamily: MyFont.alegreyaSansMedium,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: MyColor.green,
          fixedSize: Size(_width * 0.8, _width * 0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
