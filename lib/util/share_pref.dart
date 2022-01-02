

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';

class SharePref {

  static getSharePrefMemberId(BuildContext context) async {

    var member_id = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("member_id") != null && prefs.getString("member_id") != "") {
      // data['member_id'] = int.parse(sharedPreferences.getString("member_id"));
      member_id  =  prefs.getString("member_id");
    }else{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
    }
    return member_id;
  }


  static logout(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("oauth_type", "");
    prefs.setString("serverAuthCode", "");
    // sharedPreferences.setString("access_token", jsonResponse['access_token']);
    prefs.setString("member_id", "");
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);

  }



}
