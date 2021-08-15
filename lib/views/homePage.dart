import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:luna/helper/helper.dart';
import 'package:luna/views/tabs/profile.dart';
import 'package:luna/views/tabs/sounds.dart';
import 'package:luna/widgets/logo.dart';

import 'tabs/home.dart';
import 'tabs/profile.dart';
import 'tabs/sounds.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: appBar(_width),
        backgroundColor: MyColor.bgColor,
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            Home(),
            Sounds(),
            Profile(),
          ],
        ),
        bottomNavigationBar: _tabBar(_width));
  }

  AppBar appBar(double width) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.menu_rounded,
              size: width * 0.1,
            ),
          ),
          Logo(
            size: width * 0.2,
          ),
          CircleAvatar(
            child: ClipRRect(
              child: Image.network(user!.photoURL!),
              borderRadius: BorderRadius.circular(width * 0.06),
            ),
            radius: width * 0.06,
          ),
        ],
      ),
    );
  }

  Widget _tabBar(double width) {
    double _iconSize = width * 0.08;
    return TabBar(
      indicatorColor: Colors.transparent,
      unselectedLabelColor: Colors.grey,
      tabs: <Widget>[
        Tab(
          icon: Icon(
            Icons.home,
            size: _iconSize,
          ),
        ),
        Tab(
          child: Icon(Icons.music_note_rounded, size: _iconSize),
        ),
        Tab(
          child: Icon(Icons.person_rounded, size: _iconSize),
        )
      ],
      controller: _tabController,
    );
  }
}
