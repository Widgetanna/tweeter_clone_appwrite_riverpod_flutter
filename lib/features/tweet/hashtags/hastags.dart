import 'package:flutter/material.dart';
import 'package:tweeter_clone_flutter/constantes/pallette.dart';


class HashtagText extends StatelessWidget {
  final String text;
  const HashtagText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textspans = [];
    final words = text.split(' ');
    for (var element in words) {
      if (element.startsWith('#')) {
        textspans.add(
          TextSpan(
            //pour separer les mots utiliser interpolation 
              text: '$element ',
            style: const TextStyle(
              color: Pallete.blueColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        print('++Element $element');
      } else if (element.startsWith('www.') || element.startsWith('http://') || element.startsWith('https://')) {
        print('Element $element');
        textspans.add(
          TextSpan(
               text: '$element ',
            style: const TextStyle(
              color: Pallete.blueColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        textspans.add(
          TextSpan(
           text: '$element ',
            style: const TextStyle(
              fontSize: 18,
              ),
          ),
        );
      }
    }
    return RichText(
      text: TextSpan(
        children: textspans,
      ),
    );
  }
}
