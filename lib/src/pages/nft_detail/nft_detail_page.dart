import 'package:flutter/material.dart';
import 'package:polygon_hackathon_flutter/my_colors.dart';
import 'package:polygon_hackathon_flutter/src/models/nft.dart';
import 'package:polygon_hackathon_flutter/src/models/nft_detailed_to_buy.dart';
import 'package:polygon_hackathon_flutter/src/provider/nfts_detailed_provider.dart';

class NftDetailPage extends StatefulWidget {
  final NftElement nft;

  const NftDetailPage({Key key, this.nft}) : super(key: key);
  @override
  State<NftDetailPage> createState() => _NftDetailPageState(nft);
}

class _NftDetailPageState extends State<NftDetailPage> {
  NftsDetailedProvider _nftsDetailedProvider = new NftsDetailedProvider();
  final NftElement currentNft;

  _NftDetailPageState(this.currentNft);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle titleStyle = TextStyle(
        color: DonatyColors.primaryColor4,
        fontSize: size.height * 0.03,
        fontWeight: FontWeight.bold);
    TextStyle subtitleStyle = TextStyle(
      color: DonatyColors.primaryColor4,
      fontSize: size.height * 0.025,
    );
    TextStyle descriptionStyle = TextStyle(
      color: DonatyColors.primaryColor2,
      fontSize: size.height * 0.025,
    );
    return Scaffold(
        backgroundColor: DonatyColors.primaryColor1,
        body: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.5,
              // color: Colors.red,
              child: Stack(
                children: [
                  Positioned(child: Image.asset('assets/img/ellipse1.png')),
                  Positioned(
                    child: Image.asset('assets/img/ellipse2.png'),
                    top: size.height * 0.12,
                    right: size.width * 0.05,
                  ),
                  Positioned(
                    child: Image.asset('assets/img/ellipse2.png'),
                    top: size.height * 0.37,
                    left: size.width * 0.05,
                  ),
                  SafeArea(
                    child: Center(
                      child: Container(
                        width: size.width * 0.9,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(currentNft.img,
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: IconButton(
                      color: DonatyColors.primaryColor4,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width * 0.9,
              child: Text(this.currentNft.title, style: titleStyle),
            ),
            SizedBox(height: size.height * 0.01),
            FutureBuilder(
                future: _nftsDetailedProvider.getDetailedNftInformation(
                    this.currentNft.nftContract, this.currentNft.tokenId),
                builder: (context, AsyncSnapshot<NftDetailedElement> snapshot) {
                  if (snapshot.hasData) {
                    NftDetailedElement nftDetailed =
                        NftDetailedElement.fromJson(snapshot.data.toJson());
                    return Column(
                      children: [
                        Text(
                          nftDetailed.description,
                          style: subtitleStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: size.height * 0.01),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: size.width * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.32,
                                    child: Divider(
                                      color: DonatyColors.primaryColor3,
                                      thickness: 2,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.favorite_border,
                                        color: DonatyColors.primaryColor4,
                                      ),
                                      Text(
                                        " Cause",
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: DonatyColors.primaryColor4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: Text(
                        'No registered foundations',
                        style: TextStyle(
                            fontSize: size.height * 0.03,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ));
  }
}
