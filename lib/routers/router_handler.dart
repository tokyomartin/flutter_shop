import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';


Handler detailsHandler =Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    String goodsId = params['id'].first;
    print('index>details goodsID is ${goodsId}');
    return DetailsPage(goodsId);

  }
);

Handler productListHandler =Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      String shopId = params['shop_id'].first;
      print('index>productList SHOP ID is ${shopId}');
      return DetailsPage(shopId);

    }
);