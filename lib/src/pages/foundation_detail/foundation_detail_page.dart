import 'package:flutter/material.dart';
import 'package:polygon_hackathon_flutter/my_colors.dart';
import 'package:polygon_hackathon_flutter/src/models/foundation.dart';
import 'package:polygon_hackathon_flutter/src/models/post.dart';
import 'package:polygon_hackathon_flutter/src/pages/post_detail/post_detail_page.dart';
import 'package:polygon_hackathon_flutter/src/provider/posts_provider.dart';

class FoundationDetailPage extends StatefulWidget {
  final FoundationElement foundation;

  const FoundationDetailPage({Key key, this.foundation}) : super(key: key);

  @override
  State<FoundationDetailPage> createState() =>
      _FoundationDetailPageState(foundation);
}

class _FoundationDetailPageState extends State<FoundationDetailPage> {
  final FoundationElement currentFoundation;
  ScrollController _scrollController = ScrollController();
  PostsProvider _postsProvider = new PostsProvider();

  _FoundationDetailPageState(this.currentFoundation);

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {}
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle subtitleStyle = TextStyle(
      fontSize: size.height * 0.025,
      fontWeight: FontWeight.w500,
      color: DonatyColors.primaryColor4,
    );

    TextStyle desccriptionStyle = TextStyle(
      fontSize: size.height * 0.025,
      // fontWeight: FontWeight.w500,
      color: DonatyColors.primaryColor4,
    );

    return Scaffold(
      backgroundColor: DonatyColors.primaryColor1,
      body: ListView(
        children: [
          SafeArea(
            child: Column(
              children: [
                HeaderImage(size: size, currentFoundation: currentFoundation),
                SizedBox(height: size.height * 0.02),
                FoundationInfo(
                    size: size,
                    currentFoundation: currentFoundation,
                    subtitleStyle: subtitleStyle,
                    desccriptionStyle: desccriptionStyle),
              ],
            ),
          ),
          Container(
            width: size.width * 0.8,
            height: size.height * 0.3,
            child: FutureBuilder(
                future: _postsProvider
                    .getPostsByFoundationWallet(currentFoundation.ethAddress),
                builder: (context, AsyncSnapshot<List<Result>> snapshot) {
                  if (snapshot.hasData && snapshot.data.length > 0) {
                    return GridView.builder(
                        controller: _scrollController,
                        itemCount: snapshot.data?.length ?? 0,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.0,
                            crossAxisSpacing: size.width * 0.02,
                            mainAxisSpacing: size.width * 0.02),
                        itemBuilder: (BuildContext context, int index) {
                          Result post = snapshot.data[index];
                          return _postCard(post, context);
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
          ),
        ],
      ),
    );
  }

  Widget _postCard(Result post, context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PostDetailPage(post: post);
        }));
      },
      child: Container(
        height: size.height * 0.2,
        color: DonatyColors.primaryColor2,
        child: Image.network(
          post.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class FoundationInfo extends StatelessWidget {
  const FoundationInfo({
    Key key,
    @required this.size,
    @required this.currentFoundation,
    @required this.subtitleStyle,
    @required this.desccriptionStyle,
  }) : super(key: key);

  final Size size;
  final FoundationElement currentFoundation;
  final TextStyle subtitleStyle;
  final TextStyle desccriptionStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width * 0.9,
          child: Text(
            currentFoundation.name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontSize: size.height * 0.04,
                color: DonatyColors.primaryColor4,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: size.width * 0.9,
          child: Divider(
            color: DonatyColors.primaryColor2,
            thickness: 2,
          ),
        ),
        Row(
          children: [
            SizedBox(width: size.width * 0.04),
            Icon(Icons.location_on, color: DonatyColors.primaryColor3),
            Container(
              width: size.width * 0.2,
              child: Text(currentFoundation.country, style: subtitleStyle),
            ),
            Spacer(),
            Container(
              width: size.width * 0.6,
              child: Text(currentFoundation.email, style: subtitleStyle),
            ),
            SizedBox(width: size.width * 0.04),
          ],
        ),
        SizedBox(height: size.height * 0.02),
        Container(
          width: size.width * 0.9,
          height: size.height * 0.2,
          child: Text(
            currentFoundation.description,
            style: desccriptionStyle,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          width: size.width * 0.9,
          child: Divider(
            color: DonatyColors.primaryColor2,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}

class HeaderImage extends StatelessWidget {
  const HeaderImage({
    Key key,
    @required this.size,
    @required this.currentFoundation,
  }) : super(key: key);

  final Size size;
  final FoundationElement currentFoundation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.3,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: size.width,
              height: size.height * 0.3,
              color: DonatyColors.primaryColor2,
              child: Image.network(
                currentFoundation.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: CircleAvatar(
              backgroundColor: DonatyColors.primaryColor2,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: DonatyColors.primaryColor4,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
