import 'package:flutter/material.dart';
import 'package:luna/helper/helper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<List<String>> _stateOfMind = [
    ["assets/moods/1.png", "Calm"],
    ["assets/moods/2.png", "Relax"],
    ["assets/moods/3.png", "Focus"],
    ["assets/moods/4.png", "Anxious"]
  ];

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          feelingToday(_width),
        ],
      ),
    );
  }

  Widget feelingToday(double width) {
    return Container(
      height: width * 0.4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.28,
                height: width * 0.28,
                margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                padding: EdgeInsets.all(width * 0.05),
                decoration: BoxDecoration(
                  color: MyColor.yellow,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Image.asset(
                  _stateOfMind[index][0],
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                _stateOfMind[index][1],
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: MyFont.alegreyaSansRegular,
                    fontSize: width * 0.05),
              ),
            ],
          );
        },
        itemCount: _stateOfMind.length,
      ),
    );
  }
}
