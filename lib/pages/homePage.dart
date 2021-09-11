import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:luna/helper/helper.dart';
import 'package:luna/widgets/views/home.dart';
import 'package:luna/widgets/views/profile.dart';
import 'package:luna/widgets/views/sounds.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;
  bool _isReadArticlesTapped = false;

  late List<Widget> _pages;
  @override
  void initState() {
    _pages = [
      Home(
        name: _user!.displayName ?? "",
      ),
      Sounds(),
      Profile(),
    ];
    super.initState();
  }

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: _sideMenu(_width),
      appBar: appBar(_width),
      backgroundColor: MyColor.bgColor,
      body: PageStorage(
        child: _pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color _isSelected(int index) {
    return _selectedIndex == index ? MyColor.green : Colors.grey;
  }

  Widget _sideMenu(double width) {
    return Drawer(
      child: Container(
        color: MyColor.bgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Container(
                width: width,
                height: width * 0.7,
                padding: EdgeInsets.only(top: width * 0.1, left: width * 0.1),
                color: MyColor.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: width * 0.05),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(width * 0.5),
                        child: CachedNetworkImage(
                          imageUrl: _user!.photoURL!,
                          errorWidget: (context, url, error) =>
                              Icon(LineIcons.exclamationTriangle),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      _user!.displayName!,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: MyFont.alegreyaMedium,
                          fontSize: width * 0.08),
                    ),
                    Text(
                      _user!.email!,
                      style: TextStyle(
                          color: Colors.white60,
                          fontFamily: MyFont.alegreyaSansMedium,
                          fontSize: width * 0.05),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                LineIcons.home,
                color: _isSelected(0),
                size: width * 0.08,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                    color: _isSelected(0),
                    fontFamily: MyFont.alegreyaSansRegular,
                    fontSize: width * 0.07),
              ),
              onTap: () {
                _onItemTapped(0);
                Constants.isHome = !Constants.isHome;
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                LineIcons.music,
                color: _isSelected(1),
                size: width * 0.08,
              ),
              title: Text(
                'Music',
                style: TextStyle(
                    color: _isSelected(1),
                    fontFamily: MyFont.alegreyaSansRegular,
                    fontSize: width * 0.07),
              ),
              onTap: () {
                _onItemTapped(1);
                Constants.isHome = !Constants.isHome;
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                LineIcons.cog,
                color: _isSelected(2),
                size: width * 0.08,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                    color: _isSelected(2),
                    fontFamily: MyFont.alegreyaSansRegular,
                    fontSize: width * 0.07),
              ),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                LineIcons.info,
                color: Colors.grey,
                size: width * 0.08,
              ),
              title: Text(
                'Raise Issue',
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: MyFont.alegreyaSansRegular,
                    fontSize: width * 0.07),
              ),
              onTap: () {
                _launchInBrowser(
                    "https://github.com/iamAbhishekkumar/Luna/issues/new");
                Navigator.pop(context);
              },
            ),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                onExpansionChanged: (bool val) {
                  setState(() {
                    _isReadArticlesTapped = val;
                  });
                },
                collapsedIconColor: Colors.grey,
                iconColor: MyColor.green,
                collapsedTextColor: Colors.grey,
                textColor: MyColor.green,
                leading: Icon(
                  LineIcons.newspaper,
                  color: _isReadArticlesTapped ? MyColor.green : Colors.grey,
                  size: width * 0.08,
                ),
                title: Text(
                  'Books',
                  style: TextStyle(
                      fontFamily: MyFont.alegreyaSansRegular,
                      fontSize: width * 0.07),
                ),
                children: [
                  ListTile(
                    leading: Icon(
                      LineIcons.info,
                      color: MyColor.green,
                      size: width * 0.08,
                    ),
                    title: Text(
                      'How the Mind Works',
                      style: TextStyle(
                          color: MyColor.green,
                          fontFamily: MyFont.alegreyaSansRegular,
                          fontSize: width * 0.05),
                    ),
                    onTap: () {
                      _launchInBrowser(
                          "https://www.goodreads.com/book/show/835623.How_the_Mind_Works");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      LineIcons.info,
                      color: MyColor.green,
                      size: width * 0.08,
                    ),
                    title: Text(
                      'The Power Of Mind',
                      style: TextStyle(
                          color: MyColor.green,
                          fontFamily: MyFont.alegreyaSansRegular,
                          fontSize: width * 0.05),
                    ),
                    onTap: () {
                      _launchInBrowser(
                          "https://www.goodreads.com/book/show/29428514-the-power-of-mind---17-books-collection");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      LineIcons.info,
                      color: MyColor.green,
                      size: width * 0.08,
                    ),
                    title: Text(
                      'My Year Of Rest',
                      style: TextStyle(
                          color: MyColor.green,
                          fontFamily: MyFont.alegreyaSansRegular,
                          fontSize: width * 0.05),
                    ),
                    onTap: () {
                      _launchInBrowser(
                          "https://www.goodreads.com/book/show/44279110-my-year-of-rest-and-relaxation");
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar(double width) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: Builder(
        builder: (context) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                LineIcons.bars,
                size: width * 0.1,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = Constants.isHome ? 1 : 0;
                      Constants.isHome = !Constants.isHome;
                    });
                  },
                  icon: Icon(
                    Constants.isHome ? LineIcons.headphones : LineIcons.home,
                    size: width * 0.1,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
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

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

/*
  Widget _bottomNavBar(double width) {
    double _iconSize = (width * 0.08).roundToDouble();
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(LineIcons.home, size: _iconSize),
            label: "Home",
            activeIcon: Icon(LineIcons.home, size: _iconSize * 1.1)),
        BottomNavigationBarItem(
            icon: Icon(LineIcons.music, size: _iconSize),
            label: "Music",
            activeIcon: Icon(LineIcons.music, size: _iconSize * 1.1)),
        BottomNavigationBarItem(
            icon: Icon(LineIcons.user, size: _iconSize),
            label: user!.displayName,
            activeIcon: Icon(LineIcons.user, size: _iconSize * 1.1)),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey.shade400,
      selectedLabelStyle: TextStyle(
        fontFamily: MyFont.alegreyaSansRegular,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: MyFont.alegreyaSansRegular,
      ),
    );
  }
  */
