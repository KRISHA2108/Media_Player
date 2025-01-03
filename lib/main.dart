import 'package:flutter/material.dart';
import 'package:midea_playar/routes/routes.dart';
import 'package:midea_playar/screen/Detail/view/detail_page.dart';
import 'package:midea_playar/screen/Detail/provider/detail_provider.dart';
import 'package:midea_playar/screen/Favorite/view/favorite.dart';
import 'package:midea_playar/screen/Home/view/home_page.dart';
import 'package:midea_playar/screen/splash%20screen/splash_screen.dart';
import 'package:midea_playar/screen/video/provider.dart';
import 'package:midea_playar/screen/video/video_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      // DevicePreview(
      //   enabled: !kReleaseMode, builder: (context) => MyApp(), // Wrap your app
      // ),
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DetailProvider()),
        ChangeNotifierProvider(create: (context) => VideoProvider()),
      ],
      child: MaterialApp(
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.Splash: (context) => const SplashScreen(),
          Routes.homePage: (context) => const HomePage(),
          Routes.DetailPage: (context) => const DetailPage(),
          Routes.videoPage: (context) => const VideoPage(),
          Routes.favoritePage: (context) => const Favorite(),
        },
      ),
    );
  }
}
