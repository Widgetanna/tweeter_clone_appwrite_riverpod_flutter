import 'package:flutter/material.dart';
import 'package:tweeter_clone_flutter/commun/pallette.dart';

class IconButtonTweeter extends StatelessWidget {
 final IconData iconData;
  final String text;
  final VoidCallback onTap;
  
  const IconButtonTweeter({
    Key? key,
     required this.iconData,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Row(
        children: [
          Icon(
            iconData,
            color: Pallete.greyColor,
          ),
      Container(
        margin: const EdgeInsets.all(6),
      ),
      Text(
        text, style:const TextStyle(
          fontSize: 16,
        )
      )
        ],)

    );
  }
}