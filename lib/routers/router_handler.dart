import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';


Handler detailsHandler =Handler(
  handlerFunc: (context,Map<String, dynamic> params){
    if(params != null) {
      String goods_id = params['id']?.first;
      print('index>details goodsID is ${goods_id}');
      return DetailsPage(goods_id);
    }
  }
);

// handlerFunc: (context,Map<String, List<String>> params)

//TODO
// Handler productListHandler =Handler(
//     handlerFunc: (context,Map<String, dynamic> params){
//       String shop_id = params['shop_id']?.first;
//       print('index>productList SHOP ID is ${shop_id}');
//       return ProductPage(shop_id);
//
//     }
// );