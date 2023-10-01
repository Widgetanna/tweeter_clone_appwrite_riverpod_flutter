import 'package:flutter/material.dart';
import 'package:tweeter_clone_flutter/commun/pallette.dart';


class ButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
   final Color textColor;
   
  
  const ButtonWidget({
    super.key,
    required this.onTap,
    required this.label,
    this.backgroundColor = Pallete.backgroundColor,
    this.textColor = Pallete.whiteColor,
  });



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        label: Text(
          label, 
          style: TextStyle(color:textColor,
          fontSize: 16,),
       ),
        backgroundColor: backgroundColor,
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8),
      ),
    );
  }
}
