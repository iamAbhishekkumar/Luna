import 'package:flutter/material.dart';
import 'package:luna/helper/helper.dart';
import 'package:luna/model/homeModel.dart';
import 'package:luna/model/soundsModel.dart';
import 'package:luna/res/repository.dart';
import 'package:luna/widgets/errorWidget.dart';
import 'package:luna/widgets/feelingTodayWidget.dart';
import 'package:luna/widgets/loading.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
                  buildMainPage(_width, snapshot.data as List<HomeModel>),
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
        'Welcome back, Doremon!',
        style: TextStyle(
            color: Colors.white,
            fontFamily: MyFont.alegreyaMedium,
            fontSize: width * 0.085),
      ),
    );
  }

  Widget buildMainPage(double width, List<HomeModel> _list) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _list.length,
      itemBuilder: (context, index) =>
          buildTiles(_list[index].heading, _list[index].soundsModel),
    );
  }

  Widget buildTiles(String heading, List<SoundsModel> sounds) {
    return Column(
      children: [
        Text(heading),
        Container(
          height: 200,
          child: ListView.builder(
            itemBuilder: (context, index) => buildTileItems(sounds[index]),
            itemCount: sounds.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }

  Widget buildTileItems(SoundsModel soundsModel) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          width: 200,
          height: 200,
          color: Colors.green,
        ),
      ],
    );
  }
}
