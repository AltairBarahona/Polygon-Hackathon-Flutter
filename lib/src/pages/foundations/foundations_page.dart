import 'package:flutter/material.dart';
import 'package:polygon_hackathon_flutter/my_colors.dart';
import 'package:polygon_hackathon_flutter/src/models/foundation.dart';
import 'package:polygon_hackathon_flutter/src/provider/foundations_provider.dart';

import '../foundation_detail/foundation_detail_page.dart';

class FoundationsPage extends StatefulWidget {
  @override
  _FoundationsPageState createState() => _FoundationsPageState();
}

class _FoundationsPageState extends State<FoundationsPage> {
  FoundationsProvider _foundationsProvider = FoundationsProvider();
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DonatyColors.primaryColor1,
      body: SingleChildScrollView(
        child: Center(
            child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.01),
              Header(size: size),
              SizedBox(height: size.height * 0.02),
              Container(
                height: size.height * 0.8,
                child: FutureBuilder(
                  future: _foundationsProvider.getFoundations(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<FoundationElement>> snapshot) {
                    if (snapshot.hasData && snapshot.data.length > 0) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            FoundationElement foundation = snapshot.data[index];
                            return FoundationCard(
                                size: size, foundation: foundation);
                          });
                    } else if (snapshot.data?.length == 0) {
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
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class FoundationCard extends StatelessWidget {
  const FoundationCard({
    Key key,
    @required this.size,
    @required this.foundation,
  }) : super(key: key);

  final Size size;
  final FoundationElement foundation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FoundationDetailPage(foundation: foundation);
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.01),
        child: Stack(
          children: [
            Container(
              width: size.width * 0.9,
              height: size.width * 0.5,
              child: Image.network(
                foundation.image,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.6),
                colorBlendMode: BlendMode.darken,
              ),
            ),
            Positioned(
              top: size.height * 0.11,
              child: Container(
                width: size.width * 0.9,
                child: Center(
                  child: Text(
                    foundation.name,
                    style: TextStyle(
                      fontSize: size.height * 0.04,
                      color: DonatyColors.primaryColor4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
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
              Text(
                "Foundations",
                style: TextStyle(
                  fontSize: 22,
                  color: DonatyColors.primaryColor4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
