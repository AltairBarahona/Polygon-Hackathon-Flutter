import 'package:flutter/material.dart';
import 'package:polygon_hackathon_flutter/my_colors.dart';
import 'package:polygon_hackathon_flutter/src/models/post.dart';

class PostDetailPage extends StatefulWidget {
  final Result post;

  const PostDetailPage({Key key, this.post}) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState(post);
}

class _PostDetailPageState extends State<PostDetailPage> {
  final Result post;
  _PostDetailPageState(this.post);

  @override
  Widget build(BuildContext context) {
    TextStyle subtitleStyle = TextStyle(
      fontSize: MediaQuery.of(context).size.height * 0.025,
      fontWeight: FontWeight.w500,
      color: DonatyColors.primaryColor4,
    );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: DonatyColors.primaryColor1,
        body: ListView(
          children: [
            HeaderImage(
              post: post,
              size: size,
              subtitleStyle: subtitleStyle,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Divider(
                color: DonatyColors.primaryColor2,
                thickness: 2,
              ),
            ),
            Container(
              width: size.width * 0.9,
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, vertical: size.height * 0.02),
              child: Text(
                  "Published on ${post.createdAt.toString().substring(0, 10)}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: size.height * 0.025,
                      fontWeight: FontWeight.w700,
                      color: DonatyColors.primaryColor4)),
            ),
            Container(
              width: size.width * 0.9,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Text(
                "Published on ${post.description}",
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  color: DonatyColors.primaryColor4,
                ),
              ),
            ),
          ],
        ));
  }
}

class HeaderImage extends StatelessWidget {
  const HeaderImage({
    Key key,
    @required this.size,
    @required this.post,
    @required this.subtitleStyle,
  }) : super(key: key);

  final Size size;
  final Result post;
  final TextStyle subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.6,
      color: DonatyColors.primaryColor1,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.04, left: size.width * 0.04),
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
              ),
              SizedBox(
                width: size.width * 0.04,
              ),
              Center(
                child: Text(
                  "View post",
                  style: TextStyle(
                      fontSize: size.height * 0.03,
                      color: DonatyColors.primaryColor4),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Container(
            width: size.width * 0.9,
            child: Center(
              child: Text(post.title, style: subtitleStyle),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          SizedBox(height: size.height * 0.01),
          Center(
            child: Container(
              width: size.width,
              height: size.height * 0.45,
              color: DonatyColors.primaryColor2,
              child: Image.network(
                post.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
