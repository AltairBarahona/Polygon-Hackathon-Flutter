import 'package:flutter/material.dart';
import 'package:polygon_hackathon_flutter/my_colors.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DonatyColors.primaryColor1,
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Image.asset("assets/img/DonatyLogo.png"),
            Text(
              "Donaty",
              style: TextStyle(
                fontSize: 35,
                color: DonatyColors.primaryColor4,
              ),
            ),
            SizedBox(height: size.height * 0.2),
            Container(
              width: size.width * 0.7,
              child: Divider(color: DonatyColors.primaryColor2, thickness: 1),
            ),
            Text(
              "© 2022 | Mobile Design MP | All Rights Reserved",
              style: TextStyle(
                color: DonatyColors.primaryColor4,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
