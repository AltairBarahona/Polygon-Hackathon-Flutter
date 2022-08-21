import 'package:flutter/material.dart';
import 'package:polygon_hackathon_flutter/src/provider/nfts_provider.dart';
import '../../../my_colors.dart';
import '../../models/nft.dart';
import '../nft_detail/nft_detail_page.dart';

class NftListPage extends StatefulWidget {
  @override
  State<NftListPage> createState() => _NftListPageState();
}

class _NftListPageState extends State<NftListPage> {
  TextStyle subtitleStyle = TextStyle(color: DonatyColors.primaryColor4);
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    NftsProvider _nftsProvider = NftsProvider();
    return Scaffold(
      backgroundColor: DonatyColors.primaryColor1,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.02),
                Header(size: size, subtitleStyle: subtitleStyle),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  height: size.height,
                  child: FutureBuilder(
                      future: _nftsProvider.getNewestNfts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<NftElement>> snapshot) {
                        if (snapshot.hasData && snapshot.data.length > 0) {
                          return GridView.builder(
                              controller: _scrollController,
                              itemCount: snapshot.data?.length ?? 0,
                              // physics: const AlwaysScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.0,
                                      crossAxisSpacing: size.width * 0.02,
                                      mainAxisSpacing: size.width * 0.02),
                              itemBuilder: (BuildContext context, int index) {
                                NftElement nft = snapshot.data[index];
                                return _nftCard(nft, context);
                              });
                        } else if (snapshot.data?.length == 0) {
                          return Center(
                            child: Text(
                              'No registered NFTs',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nftCard(NftElement nft, context) {
    TextStyle titleStyle = TextStyle(
        color: DonatyColors.primaryColor4,
        // fontSize: MediaQuery.of(context).size.height * 0.03,
        fontWeight: FontWeight.bold);
    TextStyle subtitleStyle = TextStyle(
      color: DonatyColors.primaryColor4,
      // fontSize: MediaQuery.of(context).size.height * 0.03,
    );
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return NftDetailPage(nft: nft);
        }));
      },
      child: Container(
        child: Card(
            color: DonatyColors.primaryColor2,
            elevation: 3.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: size.width * 0.02,
                      left: size.width * 0.02,
                      right: size.width * 0.02),
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.25,
                        child: Text(
                          nft.title,
                          style: titleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.width * 0.12,
                        child: Text(
                          nft.price.toString() == "0"
                              ? "Not sell"
                              : nft.price.toString(),
                          style: subtitleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(size.width * 0.02),
                  height: size.height * 0.145,
                  child: Image.network(nft.img, fit: BoxFit.cover),
                ),
                Container(
                  width: size.width * 0.35,
                  child: Text(
                    nft.nameFoundation,
                    style: subtitleStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.size,
    @required this.subtitleStyle,
  }) : super(key: key);

  final Size size;
  final TextStyle subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width * 0.91,
          height: size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: DonatyColors.primaryColor2,
          ),
          child: Row(
            children: [
              SizedBox(width: size.width * 0.1),
              Image.asset(
                "assets/img/DonatyLogo.png",
                width: size.width * 0.2,
              ),
              Spacer(),
              Stack(children: [
                Image.asset(
                  "assets/img/TrustTransparencyBackground.png",
                  width: size.width * 0.4,
                ),
                Container(
                  width: size.width * 0.4,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("  Trust", style: subtitleStyle),
                        Text("  Transparency", style: subtitleStyle),
                        Text("  Selflessness", style: subtitleStyle),
                      ],
                    ),
                  ),
                ),
              ]),
            ],
          ),
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
                  Text(
                    "Newest NFT's",
                    style: TextStyle(
                      fontSize: 22,
                      color: DonatyColors.primaryColor4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
