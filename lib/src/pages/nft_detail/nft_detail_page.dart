import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:polygon_hackathon_flutter/my_colors.dart';
import 'package:polygon_hackathon_flutter/src/global_widgets/my_snackbar.dart';
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
    TextStyle ownedStyle = TextStyle(
      color: DonatyColors.primaryColor3,
      fontSize: size.height * 0.025,
    );
    TextStyle descriptionStyle = TextStyle(
      color: DonatyColors.primaryColor2,
      fontSize: size.height * 0.025,
    );
    return Scaffold(
        backgroundColor: DonatyColors.primaryColor1,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(size: size, currentNft: currentNft),
              NftTitle(
                  size: size, currentNft: currentNft, titleStyle: titleStyle),
              SizedBox(height: size.height * 0.01),
              FutureBuilder(
                  future: _nftsDetailedProvider.getDetailedNftInformation(
                      this.currentNft.nftContract, this.currentNft.tokenId),
                  builder:
                      (context, AsyncSnapshot<NftDetailedElement> snapshot) {
                    if (snapshot.hasData) {
                      NftDetailedElement nftDetailed =
                          NftDetailedElement.fromJson(snapshot.data.toJson());
                      return Column(
                        children: [
                          NftDescription(
                              nftDetailed: nftDetailed,
                              subtitleStyle: subtitleStyle),
                          SizedBox(height: size.height * 0.01),
                          OwnedBy(
                              size: size,
                              subtitleStyle: subtitleStyle,
                              nftDetailed: nftDetailed,
                              ownedStyle: ownedStyle),
                          SizedBox(height: size.height * 0.02),
                          NftInfoAndCopyAddress(
                              size: size,
                              subtitleStyle: subtitleStyle,
                              nftDetailed: nftDetailed),
                          SizedBox(height: size.height * 0.02),
                          CauseHeader(size: size),
                          SizedBox(height: size.height * 0.02),
                          Column(
                            children: [
                              Container(
                                width: size.width * 0.9,
                                height: size.height * 0.2,
                                child: Container(
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        nftDetailed.logoFoundation,
                                        width: size.width * 0.6,
                                        height: size.height * 0.2,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Center(
                                child: Text(
                                  nftDetailed.nameFoundation,
                                  style: titleStyle,
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Container(
                                width: size.width * 0.9,
                                height: size.height * 0.3,
                                child: Text(
                                  nftDetailed.description,
                                  style: subtitleStyle,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
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
          ),
        ));
  }
}

class NftInfoAndCopyAddress extends StatelessWidget {
  const NftInfoAndCopyAddress({
    Key key,
    @required this.size,
    @required this.subtitleStyle,
    @required this.nftDetailed,
  }) : super(key: key);

  final Size size;
  final TextStyle subtitleStyle;
  final NftDetailedElement nftDetailed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.15,
      decoration: BoxDecoration(
        border: Border.all(
          color: DonatyColors.primaryColor2,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Actual Price',
                  style: subtitleStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * 0.07,
                      child: Image.asset(
                        "assets/img/MaticLogo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    Text(
                      '${nftDetailed.price} MATIC',
                      style: subtitleStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                FlutterClipboard.copy(
                        "http://donaty-web-app.s3-website-us-east-1.amazonaws.com/#/details-nft/${nftDetailed.nftContract}/${nftDetailed.tokenId}")
                    .then((value) => MySnackbar.show(
                        context, "NFT address copied to clipboard"));
              },
              child: Container(
                padding: EdgeInsets.all(size.height * 0.015),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: DonatyColors.primaryColor3,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Copy NFT  market address',
                  style: subtitleStyle,
                ),
                // Text(
                //   '${nftDetailed.quantity}',
                //   style: titleStyle,
                // ),
              ),
            ),
          ),
          SizedBox(width: size.width * 0.05),
        ],
      ),
    );
  }
}

class CauseHeader extends StatelessWidget {
  const CauseHeader({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class OwnedBy extends StatelessWidget {
  const OwnedBy({
    Key key,
    @required this.size,
    @required this.subtitleStyle,
    @required this.nftDetailed,
    @required this.ownedStyle,
  }) : super(key: key);

  final Size size;
  final TextStyle subtitleStyle;
  final NftDetailedElement nftDetailed;
  final TextStyle ownedStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CircleAvatar(
                radius: size.width * 0.07,
                backgroundColor: DonatyColors.primaryColor4,
                child: Image.asset(
                  "assets/img/DonatyLogo.png",
                  width: size.width * 0.07,
                ),
              )),
          SizedBox(width: size.width * 0.03),
          Container(
            width: size.width * 0.25,
            child: Text(
              "owned by ",
              style: subtitleStyle,
            ),
          ),
          Container(
            width: size.width * 0.4,
            child: Text(
              nftDetailed.owned,
              style: ownedStyle,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}

class NftDescription extends StatelessWidget {
  const NftDescription({
    Key key,
    @required this.nftDetailed,
    @required this.subtitleStyle,
  }) : super(key: key);

  final NftDetailedElement nftDetailed;
  final TextStyle subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      nftDetailed.description,
      style: subtitleStyle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class NftTitle extends StatelessWidget {
  const NftTitle({
    Key key,
    @required this.size,
    @required this.currentNft,
    @required this.titleStyle,
  }) : super(key: key);

  final Size size;
  final NftElement currentNft;
  final TextStyle titleStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      child: Text(this.currentNft.title, style: titleStyle),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.size,
    @required this.currentNft,
  }) : super(key: key);

  final Size size;
  final NftElement currentNft;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    child: Image.network(currentNft.img, fit: BoxFit.cover)),
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
    );
  }
}
