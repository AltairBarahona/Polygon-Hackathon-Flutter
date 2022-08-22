import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polygon_hackathon_flutter/src/pages/foundation_detail/foundation_detail_page.dart';
import 'package:polygon_hackathon_flutter/src/pages/nft_detail/nft_detail_page.dart';
import 'package:polygon_hackathon_flutter/src/pages/nft_list/nft_list_page.dart';
import 'package:polygon_hackathon_flutter/src/pages/post_detail/post_detail_page.dart';

import 'package:polygon_hackathon_flutter/src/pages/splash/splash_page.dart';
import 'src/pages/login/login_page.dart';
import 'src/pages/home/home_page.dart';
import 'package:polygon_hackathon_flutter/src/pages/foundations/foundations_page.dart';
import 'package:polygon_hackathon_flutter/src/pages/register_foundation/register_foundation_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    return MaterialApp(
      title: "Donaty",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      initialRoute: "home",
      routes: {
        "home": (context) => HomePage(),
        "nftList": (context) => NftListPage(),
        "nftDetail": (context) => NftDetailPage(),
        "login": (context) => LoginPage(),
        "splash": (context) => SplashPage(),
        "foundations": (context) => FoundationsPage(),
        "foundationsDetail": (context) => FoundationDetailPage(),
        "postDetail": (context) => PostDetailPage(),
        "registerFoundation": (context) => RegisterFoundationPage(),
      },
    );
  }
}
