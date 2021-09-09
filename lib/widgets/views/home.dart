import 'package:flutter/material.dart';

import 'package:luna/helper/helper.dart';
import 'package:luna/model/homeModel.dart';
import 'package:luna/model/soundsModel.dart';
import 'package:luna/pages/playerPage.dart';
import 'package:luna/res/repository.dart';

import '../buildImage.dart';
import '../errorWidget.dart';
import '../feelingTodayWidget.dart';
import '../loading.dart';

class Home extends StatefulWidget {
  final String name;
  const Home({Key? key, required this.name}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future _future;

  @override
  void initState() {
    Repository _repo = Repository();
    _future = _repo.getHomeContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
        left: _width * 0.06,
      ),
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Loading();
          else if (snapshot.hasData) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  headingText(_width),
                  HowFeelingToday(),
                  buildDisplaySounds(_width, snapshot.data as List<HomeModel>),
                ],
              ),
            );
          }
          return ErrorOccurred();
        },
      ),
    );
  }

  Widget headingText(double width) {
    return Container(
      margin: EdgeInsets.only(
        top: width * 0.06,
        right: width * 0.06,
      ),
      child: Text(
        'Welcome back, ${widget.name}',
        style: TextStyle(
            color: Colors.white,
            fontFamily: MyFont.alegreyaMedium,
            fontSize: width * 0.085),
      ),
    );
  }

  Widget buildDisplaySounds(double width, List<HomeModel> _list) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _list.length,
      itemBuilder: (context, index) =>
          buildTiles(_list[index].heading, _list[index].soundsModel, width),
    );
  }

  Widget buildTiles(String heading, List<SoundsModel> sounds, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
              color: Colors.white,
              fontFamily: MyFont.alegreyaMedium,
              fontSize: width * 0.09),
        ),
        Container(
          height: width * 0.9,
          child: ListView.builder(
            itemBuilder: (context, index) =>
                buildTileItems(sounds[index], width, index),
            itemCount: sounds.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }

  Widget buildTileItems(SoundsModel soundsModel, double width, int index) {
    return Container(
      margin: EdgeInsets.only(
          right: width * 0.1, top: width * 0.06, bottom: width * 0.1),
      width: width * 0.6,
      height: width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PlayerPage(
                  soundsModel: soundsModel,
                  index: index,
                  isRandomCard: false,
                ),
              ));
            },
            child: Container(
              width: width * 0.6,
              height: width * 0.6,
              child: Hero(
                tag: soundsModel.name + index.toString(),
                child: BuildImage(
                  imageUrl: soundsModel.imageUrl,
                  radius: 20,
                  key: Key(soundsModel.name),
                ),
              ),
            ),
          ),
          Text(
            soundsModel.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white,
                fontFamily: MyFont.alegreyaSansRegular,
                fontSize: width * 0.07),
          ),
          Text(
            soundsModel.artist,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.grey,
                fontFamily: MyFont.alegreyaSansRegular,
                fontSize: width * 0.04),
          ),
        ],
      ),
    );
  }
}
