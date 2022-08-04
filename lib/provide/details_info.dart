import 'package:flutter/material.dart';
import 'package:flutter_shop/config/api_service.dart';
import 'package:flutter_shop/util/m_net.dart';
import '../model/details.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier{
  
   DetailsModel? detailResult;
   bool isLeft = true;
   bool isRight = false;

  //从后台获取商品信息

  getGoodsInfo(String id )async{

    // var formData = { 'goodId':id, };
    // await request('getGoodDetailById',formData:formData)
    await  MNet.getData(ApiService.mall_good_detail_url + id)
   .then((val){
      // var responseData= json.decode(val.toString());
      var responseData = val;

      debugPrint("--------商品详细内容");
      debugPrint(val.toString());
      // var jsonData = jsonDecode(val.toString());
      var jsonData = val;
      // goodsInfo=DetailsModel.fromJson(responseData);
      debugPrint("----FROM DETAILS INFO PAGE----商品详细内容");
      // TODO 没转化好
       detailResult = DetailsModel.fromJson(jsonData);

      debugPrint("END TEST");
      // detailResult = responseData;

      notifyListeners();
    });
   

  }
  //改变tabBar的状态
  changeLeftAndRight(String changeState){
    if(changeState=='left'){
      isLeft=true;
      isRight=false;
    }else{
      isLeft=false;
      isRight=true;
    }
     notifyListeners();

  }


}