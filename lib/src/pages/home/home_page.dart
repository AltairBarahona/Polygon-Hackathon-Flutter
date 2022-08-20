import 'package:flutter/material.dart';
import 'package:polygon_hackathon_flutter/my_colors.dart';
import 'package:polygon_hackathon_flutter/src/global_widgets/bottom_navigation_bar.dart';

import '../../../nft_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DonatyColors.primaryColor1,
      body: DonatyBottomNavigationBar(),
    );
  }

  Widget _cardProduct(Nft product, context) {
    return GestureDetector(
      onTap: () {
        // _con.openBottomSheet(product);
      },
      child: Container(
        height: 250,
        child: Card(
          elevation: 3.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Stack(
            children: [
              Positioned(
                  top: -1.0,
                  right: -1.0,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: DonatyColors.primaryColor1,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(20))),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 150,
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: EdgeInsets.all(20),
                      child: product.image1 != null
                          ? Image.network(
                              product.image1,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace stackTrace) {
                                return Image.asset('assets/img/no-image.png');
                              },
                            )
                          : AssetImage('assets/img/no-image.png')),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 33,
                    child: Text(
                      product.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15, fontFamily: 'NimbusSans'),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Text(
                      '${product.price ?? 0}\$',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NimbusSans'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
