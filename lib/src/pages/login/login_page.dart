import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:polygon_hackathon_flutter/my_colors.dart';
import 'package:web3dart/web3dart.dart';


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Client httpClient = Client();
  Web3Client ethClient;
  final myAddress = "";
  var myData;
  bool data = false;

  @override
  void initState() {
    super.initState();
    httpClient = Client();
    ethClient = Web3Client("https://rpc-mumbai.maticvigil.com", httpClient);
    // getBalance(myAddress);
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString('assets/abi.json');
    String contractAddress = "dirección del contrato";
    final contract = DeployedContract(ContractAbi.fromJson(abi, "name"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(
      contract: contract,
      function: ethFunction,
      params: args,
    );
    return result;
  }

  // Future<void> getBalance(String targetAddress) async {
  //   EthereumAddress address = EthereumAddress.fromHex(targetAddress);
  //   List<dynamic> result = await query("balanceOf", []);
  //   myData = result[0];
  //   data = true;
  //   setState(() {});
  // }
  // var connector = WalletConnect(
  //     bridge: 'https://bridge.walletconnect.org',
  //     clientMeta: const PeerMeta(
  //         name: 'My App',
  //         description: 'An app for converting pictures to NFT',
  //         url: 'https://walletconnect.org',
  //         icons: [
  //           'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
  //         ]));
  // var _session, _uri, _signature, session;

  // loginUsingMetamask(BuildContext context) async {
  //   if (!connector.connected) {
  //     try {
  //       session = await connector.createSession(onDisplayUri: (uri) async {
  //         _uri = uri;
  //         await launchUrlString(uri, mode: LaunchMode.externalApplication);
  //       });
  //       print(session.accounts[0]);
  //       setState(() {
  //         _session = session;
  //       });
  //     } catch (exp) {
  //       print(exp);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle subtitlesStyle = TextStyle(
      color: DonatyColors.primaryColor4,
      fontSize: 20,
    );

    // connector.on(
    //     'connect',
    //     (session) => setState(
    //           () {
    //             _session = _session;
    //           },
    //         ));
    // connector.on(
    //     'session_update',
    //     (payload) => setState(() {
    //           _session = payload;
    //           print(_session.accounts[0]);
    //           print(_session.chainId);
    //         }));
    // connector.on(
    //     'disconnect',
    //     (payload) => setState(() {
    //           _session = null;
    //         }));

    return Scaffold(
        backgroundColor: DonatyColors.primaryColor1,
        // body: (_session == null)
        //     ? SingleChildScrollView(
        body: SingleChildScrollView(
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
                      // loginUsingMetamask(context);
                    },
                    child: Image.asset(
                      "assets/img/MetamaskWallet.png",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
    // : Nextscreenui(
    //     walletaddress: session.accounts[0].toString(),
    //   ));
  }
}
