import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:luna/helper/helper.dart';
import 'package:luna/model/soundsModel.dart';
import 'package:luna/player/playerWidget.dart';
import 'package:luna/widgets/buildImage.dart';

class Player extends StatefulWidget {
  final SoundsModel soundsModel;
  final int index;
  const Player({Key? key, required this.soundsModel, required this.index})
      : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: appBar(_width),
        backgroundColor: MyColor.bgColor,
        body: Container(
          width: _width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: _width * 0.7,
                height: _width * 0.7,
                child: Hero(
                  tag: widget.soundsModel.name + widget.index.toString(),
                  child: BuildImage(
                    imageUrl: widget.soundsModel.imageUrl,
                    radius: _width * 0.7,
                  ),
                ),
              ),
              Text(
                widget.soundsModel.name,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: MyFont.alegreyaMedium,
                    fontSize: _width * 0.1),
              ),
              Text(widget.soundsModel.artist,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: MyFont.alegreyaMedium,
                      fontSize: _width * 0.06)),
              SizedBox(
                height: _width * 0.1,
              ),
              PlayerWidget(
                url: widget.soundsModel.soundUrl,
              )
            ],
          ),
        ));
  }

  AppBar appBar(double width) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      actions: [],
      title: Builder(
        builder: (context) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                LineIcons.angleLeft,
                size: width * 0.1,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    LineIcons.headphones,
                    size: width * 0.1,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    LineIcons.cog,
                    size: width * 0.1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
