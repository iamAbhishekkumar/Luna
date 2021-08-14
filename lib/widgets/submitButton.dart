import 'package:flutter/material.dart';
import 'package:luna/helper/helper.dart';

class SubmitButton extends StatelessWidget {
  final onPressed;
  final String text;
  const SubmitButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
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
}
