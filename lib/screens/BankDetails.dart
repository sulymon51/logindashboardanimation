import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_dash_animation/screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:http/http.dart' as http;

final Color themeColor = Colors.deepOrange;
final Color backgroundColor = Colors.white;


class BankDetail extends StatefulWidget {
  static String tag = 'bankdetail';

  @override
  _BankDetailState createState() => _BankDetailState();
}

class _BankDetailState extends State<BankDetail> {

// /htghbxviopnhg89512/p548nfubdbh/ndbzxgsdn589241/r62565ougpis

static const menuItems = <String>[
    'Access Bank',
    'Access Bank (Diamond)',
    'ALAT by WEMA',
    'ASO Savings and Loans',
    'Citibank Nigeria',
    'Ecobank Nigeria',
    'Ekondo Microfinance Bank',
    'Fidelity Bank',
    'First Bank of Nigeria',
    'First City Monument Bank',
    'Guaranty Trust Bank',
    'Heritage Bank',
    'Jaiz Bank',
    'Keystone Bank',
    'Parallex Bank',
    'Polaris Bank',
    'Providus Bank',
    'Stanbic IBTC Bank',
    'Standard Chartered Bank',
    'Sterling Bank',
    'Suntrust Bank',
    'Union Bank of Nigeria',
    'United Bank For Africa',
    'Unity Bank',
    'Wema Bank',
    'Zenith Bank',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btn1SelectedVal = 'Access Bank';
  String sorttcode = '044'; 
  String userbank = 'Access Bank';  

   exchangeToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: Colors.deepOrange,
        textColor: Colors.white);
  }


  String sortcode = '', accno = '';
   String email = "", name = "",  username = "", id = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      email = preferences.getString("email");
      name = preferences.getString("name");
      username = preferences.getString("username");
//      bonus = preferences.getString("bonus");
    });
  }

  
  // Future<List<BUser>> getBankDetails() async {
  //   var webAddress = "https://savests.com/htghbxviopnhg89512/p548nfubdbh/ndbzxgsdn589241/ncfvgbhjkestapis-xcvb/getbankdetails.php?username="+username;
  //   var response = await http.get(Uri.encodeFull(webAddress),);
  //   var res = jsonDecode(response.body);

  //   List<BUser> busers = [];

  //    for(var u in res){
  //     BUser buser = BUser(u["accountno"], u["accountname"],u["bankname"],);
  //     busers.add(buser);
  //     print(buser.accountname);
  //   }

  //   print(res);
   
  //   return res;
  // }



  @override
  void initState() {
    super.initState();
    getPref();
  } 

    
  @override
  Widget build(BuildContext context) {
    final amount = TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: InputDecoration(
        icon: Icon(Icons.dialpad, color: themeColor,),
        hintText: 'Account Number',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        )
      ),
       onChanged: (String text) {
        setState(() {
          accno = text;
          //print("id" + id);
          // print(myInfo.uid);
        });
      },
    );

    final testdroppp = Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.account_balance, color: themeColor,),
          trailing: DropdownButton<String>(
            // Must be one of items.value.
            value: _btn1SelectedVal,
            onChanged: (String newValue) {
              setState(() {
                _btn1SelectedVal = newValue;
                if (newValue == 'Access Bank') {
                  setState(() {
                    var sortcode = '044';
                    var userbbank = 'Access Bank';
                    userbank = userbbank;
                    sorttcode = sortcode;
                  });
                } else if (newValue == 'Access Bank (Diamond)') {
                  setState(() {
                    var sortcode = '063';
                    sorttcode = sortcode;
                    var userbbank = 'Access Bank (Diamond)';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'ALAT by WEMA') {
                  setState(() {
                    var sortcode = '035A';
                    sorttcode = sortcode;
                    var userbbank = 'ALAT by WEMA';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'ASO Savings and Loans') {
                  setState(() {
                    var sortcode = '401';
                    sorttcode = sortcode;
                    var userbbank = 'ASO Savings and Loans';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'Citibank Nigeria') {
                  setState(() {
                    var sortcode = '023';
                    sorttcode = sortcode;
                    var userbbank = 'Citibank Nigeria';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'Ecobank Nigeria') {
                  setState(() {
                    var sortcode = '050';
                    sorttcode = sortcode;
                    var userbbank = 'Ecobank Nigeria';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'Ekondo Microfinance Bank') {
                  setState(() {
                    var sortcode = '562';
                    sorttcode = sortcode;
                    var userbbank = 'Ekondo Microfinance Bank';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'Fidelity Bank') {
                  setState(() {
                    var sortcode = '070';
                    sorttcode = sortcode;
                    var userbbank = 'Fidelity Bank';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'First Bank of Nigeria') {
                  setState(() {
                    var sortcode = '011';
                    sorttcode = sortcode;
                    var userbbank = 'First Bank of Nigeria';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'First City Monument Bank') {
                  setState(() {
                    var sortcode = '214';
                    sorttcode = sortcode;
                    var userbbank = 'First City Monument Bank';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'Guaranty Trust Bank') {
                  setState(() {
                    var sortcode = '058';
                    sorttcode = sortcode;
                    var userbbank = 'Guaranty Trust Bank';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'Heritage Bank') {
                  setState(() {
                    var sortcode = '030';
                    sorttcode = sortcode;
                    var userbbank = 'Heritage Bank';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'Jaiz Bank') {
                  setState(() {
                    var sortcode = '301';
                    sorttcode = sortcode;
                    var userbbank = 'Jaiz Bank';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'Keystone Bank') {
                  setState(() {
                    var sortcode = '082';
                    sorttcode = sortcode;
                    var userbbank = 'Keystone Bank';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'Parallex Bank') {
                  setState(() {
                    var sortcode = '526';
                    sorttcode = sortcode;
                    var userbbank = 'Parallex Bank';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'Polaris Bank') {
                  setState(() {
                    var sortcode = '076';
                    sorttcode = sortcode;
                    var userbbank = 'Polaris Bank';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'Providus Bank') {
                  setState(() {
                    var sortcode = '101';
                    sorttcode = sortcode;
                    var userbbank = 'Providus Bank';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'Stanbic IBTC Bank') {
                  setState(() {
                    var sortcode = '221';
                    sorttcode = sortcode;
                    var userbbank = 'Stanbic IBTC Bank';
                    userbank = userbbank;
                  }); 
                }else if (newValue == 'Standard Chartered Bank') {
                  setState(() {
                    var sortcode = '068';
                    sorttcode = sortcode;
                    var userbbank = 'Standard Chartered Bank';
                    userbank = userbbank;
                  }); 
                }else if (newValue == 'Sterling Bank') {
                  setState(() {
                    var sortcode = '232';
                    sorttcode = sortcode;
                    var userbbank = 'Sterling Bank';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'Suntrust Bank') {
                  setState(() {
                    var sortcode = '100';
                    sorttcode = sortcode;
                    var userbbank = 'Suntrust Bank';
                    userbank = userbbank;
                  }); 
                }else if (newValue == 'Union Bank of Nigeria') {
                  setState(() {
                    var sortcode = '032';
                    sorttcode = sortcode;
                    var userbbank = 'Union Bank of Nigeria';
                    userbank = userbbank;
                  }); 
                }else if (newValue == 'United Bank For Africa') {
                  setState(() {
                    var sortcode = '033';
                    sorttcode = sortcode;
                    var userbbank = 'United Bank For Africa';
                    userbank = userbbank;
                  }); 
                }else if (newValue == 'Unity Bank') {
                  setState(() {
                    var sortcode = '215';
                    sorttcode = sortcode;
                    var userbbank = 'Unity Bank';
                    userbank = userbbank;
                  }); 
                } else if (newValue == 'Wema Bank') {
                  setState(() {
                    var sortcode = '035';
                    sorttcode = sortcode;
                    var userbbank = 'Wema Bank';
                    userbank = userbbank;
                  }); 
                }else if (newValue == 'Zenith Bank') {
                  setState(() {
                    var sortcode = '057';
                    sorttcode = sortcode;
                    var userbbank = 'Zenith Bank';
                    userbank = userbbank;
                  }); 
                }          
              });
            },
            items: this._dropDownMenuItems,
          ),
        ),
      ],
    );


    final payButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.blue.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 50.0,
          onPressed: () {
            // userid = ngtddki || accountno = rgn || sortcode = sfh || userbank = utgn
            var webAddress = "https://ridezmyway.com/apiall/mob/bankdetailsapi.php?dki=" + id + "&rgn=" + accno + "&sfh=" + sorttcode + "&utgn=" + userbank; 
            FocusScope.of(context).requestFocus(FocusNode());
            this._openInWebview(webAddress);
              },
          color: Colors.deepOrange,
          child: Text(
            'Verify',
           style: TextStyle(color: Colors.white)),
        ),
      ),
    );


    
    if (id == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/dashh.png'), fit: BoxFit.cover),
          ),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                AutoSizeText(
                  'Session Time-Out ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 48.0),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(30.0),
                    shadowColor: Colors.redAccent,
                    elevation: 5.0,
                    child: MaterialButton(
                      minWidth: 200.0,
                      height: 50.0,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new LoginScreen()),
                        );
                      },
                      color: Colors.redAccent,
                      child: Text("Login Again",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      );
    } else {

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            AutoSizeText(
              'Enter your Bank Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: themeColor),
              maxLines: 1,
            ),
             SizedBox(height: 10.0),
             AutoSizeText(
              'The bank details entered will be your default bank when you request for withdraws',
              style: TextStyle(fontSize: 10,),
            ),

            SizedBox(height: 30.0),
            amount,
            SizedBox(height: 10.0),
            testdroppp,
            SizedBox(height: 15.0),

            payButton,
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 70.0,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Icon(Icons.person,),
              // Icon(Icons.link,),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.white,
      child: Icon(Icons.home, color: Colors.blueAccent,), 
      onPressed: () {
         Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) => new LoginScreen()),
          );
      },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );

      
    }

   
  }

 Future<Null> _openInWebview(String url) async {
    if (await url_launcher.canLaunch(url)) {
      Navigator.of(context).push(
        MaterialPageRoute(

          builder: (ctx) => WebviewScaffold(
            initialChild: Center(child: CircularProgressIndicator()),
            url: url,
            appBar: AppBar(title: Text('Verify Bank Details'), backgroundColor: Colors.white,),
            bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Container(
              height: 70.0,
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(''),
                   FlatButton(
                    color: backgroundColor,
                    onPressed: () => setState(
                          () {
                            Navigator.pushReplacement(context,
                              new MaterialPageRoute(builder: (context) => new LoginScreen()),
                            );
                          },
                        ),
                    child: Icon(
                      Icons.home,
                      color: themeColor,
                    )
                  ),
                  Text(''),
                ],
              ),
            ),
          ),
          ),
        ),
      );
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Error'),
        ),
      );
    }
  }
}


// class BUser{

//   final String accountname;
//   final String bankname;
//   final int accountno;
  

//   BUser(this.accountname, this.bankname, this.accountno);
// }








// class VerifyBank extends StatefulWidget {
//   String userid;
//   String sortcode;
//   String accountno;
//   VerifyBank({Key key, this.userid, this.sortcode, this.accountno,}) : super(key: key);

//   @override
//   _VerifyBankState createState() => _VerifyBankState();
// }

// // final Completer<WebViewController> _controller = Completer<WebViewController>();

// class _VerifyBankState extends State<VerifyBank> {
//   @override
//   Widget build(BuildContext context) {
       
//   var webAddress = "https://savests.com/dash/moblieapp/bankdetails.php?userid=" + widget.userid + "&accountno=" + widget.accountno + "&sortcode=" + widget.sortcode;    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Verify Bank'),
//       ),
//       body: WebView(
//         initialUrl: webAddress,
//         javascriptMode: JavascriptMode.unrestricted,
//         // onWebViewCreated: (WebViewController webViewController){
//         //   _controller.complete(webViewController);
//         // },
//       ),
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         child: Container(
//           height: 70.0,
//           child:
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               // Icon(Icons.person,),
//               // Icon(Icons.link,),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//       backgroundColor: Colors.white,
//       child: Icon(Icons.home, color: Colors.blueAccent,), onPressed: () {},
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }