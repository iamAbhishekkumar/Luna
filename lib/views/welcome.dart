import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:luna/helper/helper.dart';
import 'package:luna/widgets/logo.dart';
import 'package:luna/widgets/submitButton.dart';

class WelComeScreen extends StatefulWidget {
  const WelComeScreen({Key? key}) : super(key: key);

  @override
  _WelComeScreenState createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelComeScreen> {
  double _width = 0.0;

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
              SubmitButton(onPressed: () => {}, text: "Get Started"),
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
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.w700,
              fontSize: _width * 0.08),
        ),
        Text(
          "Do meditation.Stay focused.",
          style: TextStyle(
              color: Colors.white,
              // fontFamily: MyFont.myFont,
              // fontWeight: FontWeight.w500,
              fontSize: _width * 0.05),
        ),
        Text(
          "Live a healthy life.",
          style: TextStyle(
              color: Colors.white,
              // fontFamily: MyFont.myFont,
              // fontWeight: FontWeight.w500,
              fontSize: _width * 0.05),
        )
      ],
    ));
  }
}
