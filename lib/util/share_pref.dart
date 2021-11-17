

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';

class SharePref {

  static getSharePrefMemberId(BuildContext context) async {

    var member_id = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("member_id") != null) {
      // data['member_id'] = int.parse(sharedPreferences.getString("member_id"));
      member_id  =  prefs.getString("member_id");
    }else{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
    }
    return member_id;
  }

}
