import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweeter_clone_flutter/commun/pallette.dart';




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