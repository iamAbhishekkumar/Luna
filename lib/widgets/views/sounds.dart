import 'dart:math';

import 'package:flutter/material.dart';
import 'package:luna/helper/helper.dart';
import 'package:luna/model/soundsModel.dart';
import 'package:luna/res/repository.dart';
import 'package:luna/widgets/buildImage.dart';

import '../errorWidget.dart';
import '../loading.dart';

class Sounds extends StatefulWidget {
  const Sounds({Key? key}) : super(key: key);

  @override
  _SoundsState createState() => _SoundsState();
}

class _SoundsState extends State<Sounds> {
  late Future _future;
  @override
  void initState() {
    _future = Repository().getAllSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Loading();
        else if (snapshot.hasData) {
          return SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                randomCard(snapshot.data as List<SoundsModel>, _width),
                buildAllSounds(snapshot.data as List<SoundsModel>, _width),
              ],
            ),
          );
        }
        return ErrorOccurred();
      },
    );
  }

  Widget randomCard(List<SoundsModel> list, double width) {
    int _index = getRandom(list.length - 1);
    return InkWell(
      onTap: () {},
      child: Container(
        width: width,
        height: width * 0.80,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(
                    left: width * 0.03, right: width * 0.03, top: width * 0.1),
                width: width,
                height: width * 0.65,
                child: BuildImage(
                  imageUrl: list[_index].imageUrl,
                  radius: 20,
                ),
              ),
            ),
            Positioned(
                left: width * 0.1,
                top: width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Relax Sounds",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: MyFont.alegreyaMedium,
                          fontSize: width * 0.09),
                    ),
                    Text(
                      "Sometimes the most productive thing \nyou can do is relax",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: MyFont.alegreyaSansMedium,
                          fontSize: width * 0.05),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget buildAllSounds(List<SoundsModel> list, double width) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) => _buildTiles(list[index], width),
    );
  }

  Widget _buildTiles(SoundsModel soundsModel, double width) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(
            left: width * 0.03,
            top: width * 0.03,
            bottom: width * 0.03,
            right: width * 0.06),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  height: width * 0.25,
                  width: width * 0.25,
                  margin: EdgeInsets.all(width * 0.03),
                  child: BuildImage(
                    imageUrl: soundsModel.imageUrl,
                    radius: 20,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width * 0.5,
                      child: Text(
                        soundsModel.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: MyFont.alegreyaSansMedium,
                            fontSize: width * 0.06),
                      ),
                    ),
                    Text(soundsModel.artist,
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontFamily: MyFont.alegreyaSansMedium,
                            fontSize: width * 0.045)),
                  ],
                ),
              ],
            ),
            Text(soundsModel.duration,
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: MyFont.alegreyaSansMedium,
                    fontSize: width * 0.05))
          ],
        ),
      ),
    );
  }

  int getRandom(int max) {
    Random _random = Random();
    return 0 + _random.nextInt(max - 0);
  }
}
