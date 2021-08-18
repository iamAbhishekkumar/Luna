import 'package:flutter/material.dart';
import 'package:luna/helper/helper.dart';

import 'package:luna/res/feelingToday.dart';
import 'package:luna/widgets/errorWidget.dart';

import 'package:luna/model/homeModel.dart';
import 'package:luna/model/soundsModel.dart';

class Home extends StatefulWidget {
  final String userName;
  final List<HomeModel> homeModels;
  const Home({required this.userName, required this.homeModels});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showFeelingToday = false;
  List<List<String>> _stateOfMind = [
    ["assets/moods/1.png", "Calm"],
    ["assets/moods/2.png", "Relax"],
    ["assets/moods/3.png", "Focus"],
    ["assets/moods/4.png", "Anxious"]
  ];

  @override
  void initState() {
    handleFeelingToday();
    super.initState();
  }

  void handleFeelingToday() async {
    String res = await FeelingToday().getDate();
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
    return Container(
      margin: EdgeInsets.only(
        left: _width * 0.06,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headingText(_width),
            feelingToday(_width),
            buildMainPage(_width)
          ],
        ),
      ),
    );
  }

  Widget feelingToday(double width) {
    return showFeelingToday
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: width * 0.06,
                  bottom: width * 0.06,
                ),
                child: Text(
                  'How are you feeling today?',
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontFamily: MyFont.alegreyaRegular,
                      fontSize: width * 0.065),
                ),
              ),
              Container(
                height: width * 0.3,
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
                            FeelingToday().setDate();
                            FeelingToday()
                                .setStateOfMind(_stateOfMind[index][1]);
                            setState(() {
                              showFeelingToday = false;
                            });
                          },
                          child: Container(
                            width: width * 0.22,
                            height: width * 0.22,
                            margin: EdgeInsets.only(right: width * 0.04),
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
              ),
            ],
          )
        : Container();
  }

  Widget headingText(double width) {
    return Container(
      margin: EdgeInsets.only(
        top: width * 0.06,
        right: width * 0.06,
      ),
      child: Text(
        'Welcome back,${widget.userName}!',
        style: TextStyle(
            color: Colors.white,
            fontFamily: MyFont.alegreyaMedium,
            fontSize: width * 0.085),
      ),
    );
  }

  Widget buildMainPage(double width) {
    List<HomeModel> _list = widget.homeModels;
    return _list.length != 0
        ? Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _list.length,
              itemBuilder: (context, index) =>
                  buildTiles(_list[index].heading, _list[index].soundsModel),
            ),
          )
        : ErrorOccurred();
  }

  Widget buildTiles(String heading, List<SoundsModel> sounds) {
    return Container(
      height: 150,
      child: Column(
        children: [
          Text(heading),
          ListView.builder(
            itemBuilder: (context, index) => buildTileItems(sounds[index]),
            itemCount: sounds.length,
          ),
        ],
      ),
    );
  }

  Widget buildTileItems(SoundsModel soundsModel) {
    return Container(
        // TODO : 1. build item for image,name,artist, thats all
        );
  }
}
