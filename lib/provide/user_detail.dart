import 'package:flutter/material.dart';
import 'package:flutter_shop/config/api_service.dart';
import 'package:flutter_shop/model/user_detail.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:flutter_shop/util/m_net.dart';
import 'package:flutter_shop/util/share_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';

import '../model/province.dart';

import 'dart:convert';

class UserDetailProvide with ChangeNotifier{


 var googleSignInNow = GoogleSignIn();
 GoogleSignInAccount googleSignInAccount;
 UserDetailMode userDetailMode;

  //得到购物车中的商品
  allowUserToLogin(BuildContext context) async {

    this.googleSignInAccount = await googleSignInNow.signIn();
    debugPrint("-----------1.0 this.googleSignInAccount-----------");
    debugPrint(this.googleSignInAccount.toString());

    debugPrint("--------1.1 UserDetailProvide  ---------");

    this.userDetailMode = new UserDetailMode(
        id: this.googleSignInAccount.id,
        displayName: this.googleSignInAccount.displayName,
        email: this.googleSignInAccount.email,
        photoUrl: this.googleSignInAccount.photoUrl,
        serverAuthCode: this.googleSignInAccount.serverAuthCode
    );

    debugPrint("--------1.2 UserDetailProvide ---------");

    Map data = {
      'id': this.googleSignInAccount.id,
      'email': this.googleSignInAccount.email,
      'displayName': this.googleSignInAccount.displayName,
      'photoUrl': this.googleSignInAccount.photoUrl,
      'serverAuthCode': this.googleSignInAccount.serverAuthCode,
    };

    debugPrint("--------1.3   google_login_url----------");

    var jsonResponse = null;
    // var response = await http.post("http://subicjobs.digitappstudio.com/api/login", body: data);

    var response = await http.post(ApiService.google_signup_url, body: data);
    // ?email=testshen3@dg006.com&password=blcu1234

    debugPrint(response.statusCode.toString() );
    debugPrint(response.toString() );
    if(response.statusCode ==200) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {

        debugPrint("--------1.3 signin----------");
        debugPrint(jsonResponse.toString());

        // debugPrint(jsonResponse['user_id'].toString());

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

        sharedPreferences.setString("oauth_type", 'google');
        sharedPreferences.setString("serverAuthCode", userDetailMode.serverAuthCode);
        // sharedPreferences.setString("access_token", jsonResponse['access_token']);
        sharedPreferences.setString("member_id", jsonResponse['userId'].toString());

        debugPrint("--------1.4 member_id----------");
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => IndexPage()), (Route<dynamic> route) => false);

        Fluttertoast.showToast(
            msg: "账户登录成功！",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            //timeInSecForIos: 1,
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            fontSize: 16.0
        );


      }
    }
    else {

      Fluttertoast.showToast(
          msg: "账户密码错误！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          //timeInSecForIos: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // print(response.body);
    }

      notifyListeners();
  }



  allowUserToLogout(BuildContext context) async{

    this.googleSignInAccount = await googleSignInNow.signOut();

    this.userDetailMode = null;

    notifyListeners();
  }



}