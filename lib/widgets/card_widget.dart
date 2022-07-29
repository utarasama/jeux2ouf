import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
      const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
            color: Colors.black,
            width: 1.0,
            style: BorderStyle.solid),
      ),
      child: Image.asset(path, fit: BoxFit.cover),
    );
  }
}