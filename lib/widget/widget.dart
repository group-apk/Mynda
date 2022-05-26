import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
            fontSize: 25,
        ),
        children: <TextSpan>[
          TextSpan(text: 'My', style: TextStyle(fontWeight: FontWeight.w600
              , color: Colors.black54)),
          TextSpan(text: 'NDA', style: TextStyle(fontWeight: FontWeight.w600
              , color: Colors.blue)),
        ],
      ),
    );
  }
}