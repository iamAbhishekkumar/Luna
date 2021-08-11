import 'package:flutter/material.dart';
import 'package:luna/widgets/logo.dart';

class SplashLoading extends StatelessWidget {
  const SplashLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/bg/bg1.png'),
          ),
        ),
        child: Column(
          children: [
            Logo(
              size: MediaQuery.of(context).size.height * 0.6,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.1),
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
