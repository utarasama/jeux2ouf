import 'package:flutter/material.dart';
import 'package:observer/observer.dart';

class CardWidget extends StatefulWidget {
  String image;
  CardObservable observable = CardObservable();

  CardWidget({Key? key, required this.image}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardState();
}

class _CardState extends State<CardWidget> {
  bool flipped = false;
  String imageDisplayed = "";
  String imageVerso = "image_verso.png";

  @override
  void initState() {
    super.initState();
    flipped = false;
    imageDisplayed = imageVerso;
  }

  void toggleFlipped() {
    setState(() {
      if (flipped) {
        initState();
      } else {
        flipped = true;
        imageDisplayed = widget.image;
      }
    });
    widget.observable.setObserver(imageDisplayed);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        toggleFlipped();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
        // padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
              color: Colors.black, width: 1.0, style: BorderStyle.solid),
        ),
        child: Image.asset(imageDisplayed, fit: BoxFit.cover),
      ),
    );
  }
}

class CardObservable with Observable {
  void setObserver(String value) {
    notifyObservers(value);
  }
}
