import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:luna/helper/helper.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    final _user = FirebaseAuth.instance.currentUser;
    return _user != null
        ? Container(
            width: _width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  minRadius: _width * 0.26,
                  backgroundColor: Colors.white,
                  child: Container(
                    height: _width * 0.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_width),
                      child: CachedNetworkImage(
                        imageUrl: _user.photoURL!,
                        errorWidget: (context, url, error) =>
                            Icon(LineIcons.exclamationTriangle),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  _user.displayName!,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: MyFont.alegreyaMedium,
                      fontSize: _width * 0.085),
                ),
                Text(
                  _user.email!,
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontFamily: MyFont.alegreyaSansMedium,
                      fontSize: _width * 0.05),
                ),
                SizedBox(
                  height: _width * 0.1,
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () async {},
                    child: Text(
                      "Login Out",
                      style: TextStyle(
                        fontSize: _width * 0.07,
                        color: Colors.white,
                        fontFamily: MyFont.alegreyaSansMedium,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: MyColor.green,
                      fixedSize: Size(_width * 0.8, _width * 0.15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
