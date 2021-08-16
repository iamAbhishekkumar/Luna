import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:luna/helper/helper.dart';
import 'package:luna/model/homeModel.dart';
import 'package:luna/res/repository.dart';
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
  int _selectedIndex = 0;
  @override
  void initState() {
    // testing();
    super.initState();
  }

  void testing() async {
    List<HomeModel> list = await Repository().getHomeContent();
    print(list.length);
    for (HomeModel h in list) {
      print(h.heading);
      print(h.soundsModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(_width),
      backgroundColor: MyColor.bgColor,
      bottomNavigationBar: _bottomNavBar(_width),
      body: _views.elementAt(_selectedIndex),
    );
  }

  static const List<Widget> _views = <Widget>[
    Home(),
    Sounds(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _bottomNavBar(double width) {
    double _iconSize = width * 0.08;
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home, size: _iconSize),
            label: "Home",
            activeIcon: Icon(Icons.home, size: _iconSize * 1.2)),
        BottomNavigationBarItem(
            icon: Icon(Icons.music_note_rounded, size: _iconSize),
            label: "Music",
            activeIcon: Icon(Icons.music_note_rounded, size: _iconSize * 1.2)),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded, size: _iconSize),
            label: user!.displayName,
            activeIcon: Icon(Icons.person_rounded, size: _iconSize * 1.2)),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(
          color: Colors.white,
          fontFamily: MyFont.alegreyaSansRegular,
          fontSize: width * 0.05),
      unselectedLabelStyle: TextStyle(
          color: Colors.white,
          fontFamily: MyFont.alegreyaSansRegular,
          fontSize: width * 0.05),
    );
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
}
