import 'package:flutter/material.dart';
import 'package:flutter_tweeter_clone/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class UIConstants {
  static AppBar appBar() {
   return AppBar(
      title: const Center(
        child: Icon(
          FontAwesomeIcons.twitter,
          size: 30,
          color: Pallete.blueColor,
        ),
      ),
      //pour centrer icone dans android 
      centerTitle: true,
    );
  }
}
/*
  static const List<Widget> bottomTabBarPages = [
   //TweetList(),
  const Text('Home Screen'),
  const Text('Search Screen'),
  const Text('Notification Screen'),
  ];
}
*/