import 'package:flutter/material.dart';
import 'package:flutter_shop/config/api_service.dart';
import 'package:flutter_shop/util/m_net.dart';
import 'package:flutter_shop/util/share_pref.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';

import '../model/province.dart';

import 'dart:convert';

class ProvinceProvide with ChangeNotifier{


  List<ProvinceMode> myDataList=[]; //商品列表对象

  //得到购物车中的商品
  getList(BuildContext context) async {
     final Map<String, dynamic> data = new Map<String, dynamic>();

     // SharedPreferences prefs = await SharedPreferences.getInstance();
     // if(prefs.getString("member_id") != null) {
     //   // data['member_id'] = int.parse(sharedPreferences.getString("member_id"));
     //   data['member_id'] =  prefs.getString("member_id");
     // }else{
     //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
     // }

     // var provinceMode = new ProvinceMode();
     // provinceMode.id =1;
     // provinceMode.pref_name = "Tokyo";
     // myDataList.add(provinceMode);

     data['member_id'] = await SharePref.getSharePrefMemberId(context);


     myDataList = [];

      await MNet.getData(ApiService.mall_province_list_url).then((val) {

       myDataList = [];
       debugPrint("提交到购物车接口");
       debugPrint(val.toString());
       debugPrint("结束 提交购物车1");

       var data = val;
       List myList = (data['data'] as List).cast();
       myList.forEach((item) {
         // debugPrint(item.toString());
         myDataList.add(new ProvinceMode.fromJson(item));
       });
     });


     debugPrint("province list");


     // await Provider.of<CartProvide>(context, listen: false).save(goodsID,goodsName,count,price,images);
     // await Provider.of<DeliveryAddrProvide>(context, listen: false).save(id,product_name,quantity,general_price,images);

     //获得购物车中的商品,这时候是一个字符串
     // cartString=prefs.getString('cartInfo');

      notifyListeners();
  }



}