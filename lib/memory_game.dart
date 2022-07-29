import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'dart:convert';
import 'widgets/card_widget.dart';
import "package:observer/observer.dart";

class MemoryGame extends StatefulWidget {
  const MemoryGame({Key? key}) : super(key: key);

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> with Observer {
  List<CardWidget> cardsFlipped = List.empty();

  @override
  void initState() {
    super.initState();
  }

  //updates gets called when observable gets observed and observable notifies
  @override
  void update(Observable observable, Object arg) {
    //check which observable called update
    switch (observable.runtimeType) {
      case CardWidget:
        var value = arg as CardWidget;
        cardsFlipped.add(value);
        if (cardsFlipped.length >= 2 && cardsFlipped[0].image == cardsFlipped[1].image) {
          Future.delayed(const Duration(seconds: 1), (){
            print("Executed after 5 seconds");
          });
          final resetObservable = ResetObservable();
          resetObservable.notifyObservers(0);
        }
        break;
      case ResetObservable:
        print("reset is heeeere truc2Ouf");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final observer = _MemoryGameState();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory cards'),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString('AssetManifest.json'),
        builder: (context, item) {
          if (item.hasData) {
            Map? jsonMap = json.decode(item.data!);
            List? images = jsonMap?.keys.where((image) => image.contains("memory_cards")).toList();
            // List? images = jsonMap?.keys.where((element) => element.endsWith(".mp3")).toList();
            var randomImages = images!.sample(10);
            // print("Sélection 1 : $randomImages");
            List? doubleRandomImages = List.empty(growable: true);
            for (var randomImage in randomImages) {
              doubleRandomImages.add(randomImage);
              doubleRandomImages.add(randomImage);
            }
            doubleRandomImages.shuffle();
            // print("Sélection 2 : $doubleRandomImages");
            return GridView.builder(
              itemCount: doubleRandomImages?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                var path = doubleRandomImages![index].toString();
                var observableCard = CardWidget(image: path);
                observableCard.addObserver(observer);
                return observableCard;
              },
            );
          } else {
            return const Center(
              child: Text("No Cards in the Assets"),
            );
          }
        },
      ),
    );
  }
}

class ResetObservable with Observable {}