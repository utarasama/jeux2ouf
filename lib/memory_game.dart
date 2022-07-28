import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

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
        title: const Text('Jeux2ouf'),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString('AssetManifest.json'),
        builder: (context, item) {
          if (item.hasData) {
            Map? jsonMap = json.decode(item.data!);
            List? songs = jsonMap?.keys.toList();
            // List? songs = jsonMap?.keys.where((element) => element.endsWith(".mp3")).toList();

            return ListView.builder(
              itemCount: songs?.length,
              itemBuilder: (context, index) {
                var path = songs![index].toString();
                var title = path.split("/").last.toString(); //get file name
                title = title.replaceAll("%20", ""); //remove %20 characters
                title = title.split(".").first;

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
                  child: ListTile(
                    textColor: Colors.black,
                    title: Text(title),
                    subtitle: Text(
                      "path: $path",
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    leading: const Icon(
                      Icons.image,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                );
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
