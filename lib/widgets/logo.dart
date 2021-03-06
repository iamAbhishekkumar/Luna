import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double size;
  const Logo({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/logo.png',
        fit: BoxFit.contain,
        width: size,
        height: size,
      ),
    );
  }
}
