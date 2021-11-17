import 'package:flutter/material.dart';
import 'package:flutter_shop/config/api_service.dart';
import 'package:flutter_shop/util/m_net.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';

import '../model/pay_method.dart';

import 'dart:convert';

class CartToConfirmProvide with ChangeNotifier{

  // List<PayMethodMode> myDataList=[]; //商品列表对象

  double allPrice =0 ;   //总价格

  int delivery_address_id = 0;
  int pay_method = 4;  //默认 货到付款
  int card_seq = 0;



  //删除购物车中的商品
  remove() async{
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // //prefs.clear();//清空键值对
    // prefs.remove('cartInfo');

    allPrice =0 ;
    print('清空完成-----------------');
    notifyListeners();
  }







  

}