import 'package:flutter/material.dart';
import 'package:luna/helper/helper.dart';
import 'package:luna/res/feelingTodayPrefs.dart';

class HowFeelingToday extends StatefulWidget {
  const HowFeelingToday({Key? key}) : super(key: key);

  @override
  _HowFeelingTodayState createState() => _HowFeelingTodayState();
}

class _HowFeelingTodayState extends State<HowFeelingToday> {
  bool showFeelingToday = false;
  @override
  void initState() {
    handleFeelingToday();
    super.initState();
  }

  List<List<String>> _stateOfMind = [
    ["assets/moods/1.png", "Calm"],
    ["assets/moods/2.png", "Relax"],
    ["assets/moods/3.png", "Focus"],
    ["assets/moods/4.png", "Anxious"]
  ];
  void handleFeelingToday() async {
    String res = await FeelingTodayPrefs().getDate();
    DateTime dateToday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    setState(() {
      if (res.length != 0 && res == dateToday.toString()) {
        setState(() {
          showFeelingToday = false;
        });
      } else {
        setState(() {
          showFeelingToday = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return showFeelingToday
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: _width * 0.06,
                  bottom: _width * 0.06,
                ),
                child: Text(
                  'How are you feeling today?',
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontFamily: MyFont.alegreyaRegular,
                      fontSize: _width * 0.065),
                ),
              ),
              Container(
                height: _width * 0.3,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            FeelingTodayPrefs().setDate();
                            FeelingTodayPrefs()
                                .setStateOfMind(_stateOfMind[index][1]);
                            setState(() {
                              showFeelingToday = false;
                            });
                          },
                          child: Container(
                            width: _width * 0.22,
                            height: _width * 0.22,
                            margin: EdgeInsets.only(right: _width * 0.04),
                            padding: EdgeInsets.all(_width * 0.05),
                            decoration: BoxDecoration(
                              color: MyColor.yellow,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Image.asset(
                              _stateOfMind[index][0],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          _stateOfMind[index][1],
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: MyFont.alegreyaSansRegular,
                              fontSize: _width * 0.05),
                        ),
                      ],
                    );
                  },
                  itemCount: _stateOfMind.length,
                ),
              ),
            ],
          )
        : Container();
  }
}
