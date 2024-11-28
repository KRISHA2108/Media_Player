import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:midea_playar/routes/routes.dart';
import 'package:midea_playar/screen/Detail/provider/detail_provider.dart';
import 'package:midea_playar/screen/video/video_page.dart';
import 'package:provider/provider.dart';

import '../../Detail/provider/detail_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List image = [
    'lib/assets/images/b_image/1b.jpeg',
    'lib/assets/images/b_image/2b.jpg',
    'lib/assets/images/b_image/3b.jpeg',
    'lib/assets/images/b_image/4b.jpeg',
    'lib/assets/images/b_image/5b.jpeg',
  ];
  late TabController tabController;

  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  late DetailProvider homeProviderR = DetailProvider();
  late DetailProvider homeProviderW = DetailProvider();

  @override
  Widget build(BuildContext context) {
    homeProviderW = context.watch<DetailProvider>();
    homeProviderR = context.read<DetailProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/favorite');
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.black,
        title: const Text(
          "Media Player",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          controller: tabController,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.music_note,
                color: Colors.white,
              ),
              text: 'Music',
            ),
            Tab(
              icon: Icon(
                Icons.video_camera_back_outlined,
                color: Colors.white,
              ),
              text: 'Video',
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: TabBarView(
        controller: tabController,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CarouselSlider(
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      homeProviderR.pageChange(index);
                    }),
                items: image
                    .map(
                      (e) => Container(
                        height: 100,
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(e),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  image.length,
                  (index) {
                    return Container(
                      height: 10,
                      width: 10,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: index != homeProviderW.pageIndex
                            ? Colors.grey
                            : Colors.white,
                      ),
                    );
                  },
                ),
              ),

              // TabBar(
              //   controller: tabController,
              //   tabs: const [
              //     Tab(icon: Icon(Icons.home), text: 'Home'),
              //     Tab(icon: Icon(Icons.settings), text: 'Settings'),
              //     Tab(icon: Icon(Icons.person), text: 'Profile'),
              //   ],
              // ),
              // TabBarView(
              //   controller: tabController,
              //   children: const [
              //     Center(child: Text('Home Page')),
              //     Center(child: Text('Settings Page')),
              //     Center(child: Text('Profile Page')),
              //   ],
              // ),
              Expanded(
                flex: 1,
                child: GridView.builder(
                  itemCount: context.read<DetailProvider>().musicList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      context.read<DetailProvider>().musicList;
                      context.read<DetailProvider>().index(index);
                      Navigator.pushNamed(context, Routes.DetailPage,
                          arguments: homeProviderW.musicList[index]);
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(context
                                  .read<DetailProvider>()
                                  .musicList[index]
                                  .b_image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const VideoPage(),
        ],
      ),
    );
  }
}
