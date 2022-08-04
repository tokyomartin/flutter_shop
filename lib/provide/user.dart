import 'package:flutter/material.dart';
import 'package:flutter_shop/config/api_service.dart';
import 'package:flutter_shop/model/user.dart';

import 'package:flutter_shop/pages/index_page.dart';
import 'package:flutter_shop/util/m_net.dart';
import 'package:flutter_shop/util/share_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';

import '../model/province.dart';

import 'dart:convert';

class UserProvider with ChangeNotifier{

 UserModel? userModel;

  //得到购物车中的商品
 signup( String email, String password, String password_confirmation) async {



    debugPrint("--------1.1 UserProvider  ---------");

    this.userModel = new UserModel(
        email: email,
        password: password,
        password_confirmation: password_confirmation
    );
    debugPrint("--------1.2 UserProvider ---------");

    Map data = {
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation
    };

    debugPrint("--------1.3   user_register_url----------");

    var jsonResponse = null;
    // var response = await http.post("http://subicjobs.digitappstudio.com/api/login", body: data);

    var url = Uri.parse(ApiService.user_signup_url);
    var response = await http.post(url, body: data);
    // ?email=testshen3@dg006.com&password=blcu1234

    debugPrint(response.statusCode.toString() );
    debugPrint(response.toString() );
    if(response.statusCode ==201) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {

        debugPrint("--------1.3 signin----------");
        debugPrint(jsonResponse.toString());

        // debugPrint(jsonResponse['user_id'].toString());

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

        sharedPreferences.setString("oauth_type", '');

        sharedPreferences.setString("access_token", jsonResponse['access_token']);
        //sharedPreferences.setString("member_id", jsonResponse['userId'].toString());
        sharedPreferences.setString("user_id", jsonResponse['userId'].toString());

        debugPrint("--------1.4 member_id----------");


        Fluttertoast.showToast(
            msg: "账户注册成功！",
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
          msg: "账户注册失败！",
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

    // this.googleSignInAccount = await googleSignInNow.signOut();
    //
    // this.userDetailMode = null;

    notifyListeners();
  }



}