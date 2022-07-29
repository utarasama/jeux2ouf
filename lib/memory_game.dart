import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'dart:convert';
import 'widgets/card_widget.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({Key? key}) : super(key: key);

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  void _newGame() async {
    // get 4 random images from the assets folder
    var assetsFile =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(assetsFile);
    List<String> images = manifestMap.keys
        .where((String key) => key.startsWith('assets/memory_cards'))
        .toList();
    List<String> randomImages = _getRandomImages(5, images);
    print(randomImages);
  }

  @override
  void initState() {
    super.initState();
    //_newGame();
  }

  @override
  Widget build(BuildContext context) {
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
            print("Sélection 1 : $randomImages");
            List? doubleRandomImages = List.empty(growable: true);
            for (var randomImage in randomImages) {
              doubleRandomImages.add(randomImage);
              doubleRandomImages.add(randomImage);
            }
            doubleRandomImages.shuffle();
            print("Sélection 2 : $doubleRandomImages");
            return GridView.builder(
              itemCount: doubleRandomImages?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                var path = doubleRandomImages![index].toString();
                var title = path.split("/").last.toString(); //get file name
                title = title.replaceAll("%20", ""); //remove %20 characters
                title = title.split(".").first;

                return CardWidget(imageRecto: path);
              },
            );
          } else {
            return const Center(
              child: Text("No Images in the Assets"),
            );
          }
        },
      ),
    );
  }

  List<String> _getRandomImages(int amount, List<String> cardImagesList) =>
      cardImagesList.sample(amount);
}
