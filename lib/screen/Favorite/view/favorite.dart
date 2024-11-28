import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:midea_playar/screen/Detail/provider/detail_provider.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  late DetailProvider detailProviderR;
  late DetailProvider detailProviderW;
  @override
  Widget build(BuildContext context) {
    detailProviderR = context.read<DetailProvider>();
    detailProviderW = context.watch<DetailProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4,
          ),
          itemCount: detailProviderW.fav.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                detailProviderR.currentIndex = index;

                detailProviderR.audioPlayer.play;
                // mediaProviderR.changeIndex(index);
                Navigator.pushNamed(context, '/detail',
                    arguments: detailProviderR.fav[index]);
              },
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          detailProviderW.fav[index].b_image!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    '${detailProviderW.fav[index].title}',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
