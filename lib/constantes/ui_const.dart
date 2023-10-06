import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweeter_clone_flutter/constantes/pallette.dart';
import 'package:tweeter_clone_flutter/features/explore/explore_view.dart';
import 'package:tweeter_clone_flutter/features/tweet/tweet_widgets/tweet_list.dart';


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


  static const List<Widget> bottomTabBarPages = [
  TweetList(),
  ExploreView(),
  const Text('Notification Screen'),
  ];
}
