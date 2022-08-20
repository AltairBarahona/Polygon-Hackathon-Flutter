import 'package:flutter/material.dart';
import 'package:polygon_hackathon_flutter/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

import 'home_metamask_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'My App',
          description: 'An app for converting pictures to NFT',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));
  var _session, _uri, _signature, session;

  loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        print(session.accounts[0]);
        setState(() {
          _session = session;
        });
      } catch (exp) {
        print(exp);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle subtitlesStyle = TextStyle(
      color: DonatyColors.primaryColor4,
      fontSize: 20,
    );

    connector.on(
        'connect',
        (session) => setState(
              () {
                _session = _session;
              },
            ));
    connector.on(
        'session_update',
        (payload) => setState(() {
              _session = payload;
              print(_session.accounts[0]);
              print(_session.chainId);
            }));
    connector.on(
        'disconnect',
        (payload) => setState(() {
              _session = null;
            }));

    return Scaffold(
        backgroundColor: DonatyColors.primaryColor1,
        body: (_session == null)
            ? SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/img/CurvedHearthCard.png",
                          width: size.width * 0.7,
                        ),
                        Text(
                          "Donaty",
                          style: TextStyle(
                            fontSize: 35,
                            color: DonatyColors.primaryColor4,
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/img/DonatyLogo.png"),
                            SizedBox(width: size.width * 0.1),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Openness", style: subtitlesStyle),
                                Text("Charity", style: subtitlesStyle),
                                Text("Projects", style: subtitlesStyle)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: size.height * 0.05),
                        Text(
                          "© 2022 | Mobile Design Donaty | All Rights Reserved",
                          style: TextStyle(
                            color: DonatyColors.primaryColor4,
                          ),
                        ),
                        Container(
                          width: size.width * 0.7,
                          child: Divider(
                              color: DonatyColors.primaryColor2, thickness: 1),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Text(
                          "Connect your Metamask wallet",
                          style: subtitlesStyle,
                        ),
                        SizedBox(height: size.height * 0.05),
                        GestureDetector(
                          onTap: () {
                            loginUsingMetamask(context);
                          },
                          child: Image.asset(
                            "assets/img/MetamaskWallet.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Nextscreenui(
                walletaddress: session.accounts[0].toString(),
              ));
  }
}
