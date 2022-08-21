import 'package:flutter/material.dart';
import 'package:polygon_hackathon_flutter/my_colors.dart';
import 'package:polygon_hackathon_flutter/src/global_widgets/bottom_navigation_bar.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DonatyColors.primaryColor1,
      body: DonatyBottomNavigationBar(),
    );
  }
}
