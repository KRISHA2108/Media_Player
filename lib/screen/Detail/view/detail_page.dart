import 'package:flutter/material.dart';
import 'package:midea_playar/screen/Detail/provider/detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../utils/model/model_utils.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late DetailProvider homeProviderR;
  late DetailProvider homeProviderW;
  @override
  void initState() {
    context.read<DetailProvider>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MusicModel model = ModalRoute.of(context)!.settings.arguments as MusicModel;
    homeProviderR = context.read<DetailProvider>();
    homeProviderW = context.watch<DetailProvider>();
    homeProviderR.getMusicDuration();
    model = homeProviderW.musicList[homeProviderW.currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: Image(
              image: NetworkImage(model.b_image),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: double.infinity,
            color: Colors.black.withOpacity(0.9),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 45),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 45),
                child: IconButton(
                  onPressed: () {
                    Share.share(
                        "${model.title}\n ${model.singer}\n ${model.path}");
                  },
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: const Alignment(0, -0.3),
            child: Container(
              height: 300,
              width: 300,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(model.f_image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.3),
            child: Container(
              height: 320,
              width: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // Text(
                  //   model.title,
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 30,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  const SizedBox(
                    height: 470,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                model.singer,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          homeProviderW.fav.contains(model)
                              ? homeProviderW.fav.remove(model)
                              : homeProviderW.fav.add(model);
                        },
                        icon: homeProviderW.fav.contains(model)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 25,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 25,
                              ),
                      ),
                    ],
                  ),

                  Slider(
                    value: homeProviderW.liveDuration.inSeconds.toDouble(),
                    max: homeProviderW.totalDuration.inSeconds.toDouble(),
                    onChanged: (value) {
                      homeProviderR.seekSong(
                        Duration(
                          seconds: value.toInt(),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        homeProviderW.liveDuration
                            .toString()
                            .trimRight()
                            .split(".")[0],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        homeProviderW.totalDuration
                            .toString()
                            .trimRight()
                            .split(".")[0],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shuffle,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          homeProviderR.previousSong();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          homeProviderR.playOrPause();
                        },
                        icon: (homeProviderW.play)
                            ? const Icon(
                                Icons.pause_circle_filled,
                                color: Colors.white,
                                size: 50,
                              )
                            : const Icon(
                                Icons.play_circle_filled,
                                color: Colors.white,
                                size: 50,
                              ),
                      ),
                      IconButton(
                        onPressed: () {
                          homeProviderR.nextSong();
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          homeProviderR.restart();
                        },
                        icon: const Icon(
                          Icons.repeat,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
