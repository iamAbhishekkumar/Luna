import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double size;
  const Logo({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Image.asset(
        'assets/icons/logo.png',
        fit: BoxFit.contain,
        width: size,
        height: size,
      ),
    );
  }
}
