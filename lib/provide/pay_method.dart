import 'package:flutter/material.dart';
import 'package:flutter_shop/config/api_service.dart';
import 'package:flutter_shop/util/m_net.dart';
import 'package:flutter_shop/util/share_pref.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';

import '../model/pay_method.dart';

import 'dart:convert';

class PayMethodProvide with ChangeNotifier{

  String cartString="[]";
  List<PayMethodMode> myDataList=[]; //商品列表对象

  double allPrice =0 ;   //总价格
  int allGoodsCount =0;  //商品总数量
  bool isAllCheck= true; //是否全选

  // save(product_id, product_name, num, price, images) async{
  //   //初始化SharedPreferences
  //   SharedPreferences prefs = await  SharedPreferences.getInstance();
  //   cartString=prefs.getString('cartInfo');  //获取持久化存储的值
  //   var temp=cartString==null?[]:json.decode(cartString.toString());
  //   //把获得值转变成List
  //   List<Map> tempList= (temp as List).cast();
  //   //声明变量，用于判断购物车中是否已经存在此商品ID
  //   var isHave= false;  //默认为没有
  //   int ival=0; //用于进行循环的索引使用
  //   allPrice=0;
  //   allGoodsCount=0;  //把商品总数量设置为0
  //   tempList.forEach((item){//进行循环，找出是否已经存在该商品
  //     //如果存在，数量进行+1操作
  //
  //   });
  //   //  如果没有，进行增加
  //   if(!isHave){
  //     Map<String, dynamic> newGoods={
  //       'product_id':product_id,
  //       'product_name':product_name,
  //       'num':num,
  //       'price':price,
  //       'images':images,
  //       'isCheck': true  //是否已经选择
  //     };
  //     tempList.add(newGoods);
  //     cartList.add(new DeliveryAddrMode.fromJson(newGoods));
  //     allPrice+= (num * price);
  //     allGoodsCount+=num;
  //   }
  //   //把字符串进行encode操作，
  //   cartString= json.encode(tempList).toString();
  //
  //   prefs.setString('cartInfo', cartString);//进行持久化
  //   notifyListeners();
  // }
  //

  //删除购物车中的商品
  remove() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    myDataList=[];
    allPrice =0 ;
    allGoodsCount=0;
    print('清空完成-----------------');
    notifyListeners();
  }

  //得到购物车中的商品
  getListInfo(BuildContext context) async {

     // SharedPreferences prefs = await SharedPreferences.getInstance();
     final Map<String, dynamic> data = new Map<String, dynamic>();

     data['member_id'] = await SharePref.getSharePrefMemberId(context);




     myDataList = [];

     var payMethodMode = new PayMethodMode();
     payMethodMode.pay_id =1;
     payMethodMode.pay_name = "微信扫码支付";
     myDataList.add(payMethodMode);

     // var payMethodMode3 = new PayMethodMode();
     // payMethodMode3.pay_id =3;
     // payMethodMode3.pay_name = "信用卡付款";
     // myDataList.add(payMethodMode3);

     var payMethodMode4 = new PayMethodMode();
     payMethodMode4.pay_id =4;
     payMethodMode4.pay_name = "货到付款";
     myDataList.add(payMethodMode4);

     // MNet.oauthGet(ApiService.user_delivery_addr_url, data).then((val) {
     //
     //   myDataList = [];
     //   debugPrint("提交到购物车接口");
     //   debugPrint(val.toString());
     //   debugPrint("结束 提交购物车1");
     //
     //   var data = val;
     //   List<Map> myList = (data['data'] as List).cast();
     //   myList.forEach((item) {
     //     debugPrint(item.toString());
     //     myDataList.add(new PayMethodMode.fromJson(item));
     //   });
     // });


     debugPrint("结束 支付方式");


     // await Provider.of<CartProvide>(context, listen: false).save(goodsID,goodsName,count,price,images);
     // await Provider.of<DeliveryAddrProvide>(context, listen: false).save(id,product_name,quantity,general_price,images);

     //获得购物车中的商品,这时候是一个字符串
     // cartString=prefs.getString('cartInfo');

      notifyListeners();
  }

  //删除单个购物车商品
  deleteOneGoods(BuildContext context, int product_id) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var cartString= prefs.getString('cartInfo');
     List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
   
     int tempIndex =0;
     int delIndex=0;
     tempList.forEach((item){
         
         if(item['product_id']==product_id){
          delIndex=tempIndex;
         }
         tempIndex++;
     });
      tempList.removeAt(delIndex);
      cartString= json.encode(tempList).toString();
      prefs.setString('cartInfo', cartString);//
      await getListInfo(context);
     

  }

  // //修改选中状态
  // changeCheckState(BuildContext context, PayMethodMode cartItem) async{
  //    SharedPreferences prefs = await SharedPreferences.getInstance();
  //    cartString=prefs.getString('cartInfo');
  //    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
  //    int tempIndex =0;
  //    int changeIndex=0;
  //    tempList.forEach((item){
  //
  //        if(item['product_id']==cartItem.product_id){
  //         changeIndex=tempIndex;
  //        }
  //        tempIndex++;
  //    });
  //    tempList[changeIndex]=cartItem.toJson();
  //    cartString= json.encode(tempList).toString();
  //    prefs.setString('cartInfo', cartString);//
  //    await getListInfo(context);
  //
  // }
  //
  // //点击全选按钮操作
  // changeAllCheckBtnState(BuildContext context, bool isCheck) async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   cartString=prefs.getString('cartInfo');
  //   List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
  //   List<Map> newList=[];
  //   for(var item in tempList ){
  //     var newItem = item;
  //     newItem['isCheck']=isCheck;
  //     newList.add(newItem);
  //   }
  //
  //    cartString= json.encode(newList).toString();
  //    prefs.setString('cartInfo', cartString);//
  //    await getListInfo(context);
  //
  // }

  //增加减少数量的操作

  addOrReduceAction(BuildContext context, var cartItem, String todo )async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartString=prefs.getString('cartInfo');
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    int tempIndex =0;
    int changeIndex=0;
    tempList.forEach((item){
         if(item['product_id']==cartItem.product_id){
          changeIndex=tempIndex; 
         }
         tempIndex++;
     });
     if(todo=='add'){
       cartItem.num++;
     }else if(cartItem.num>1){
       cartItem.num--;
     }
     tempList[changeIndex]=cartItem.toJson();
     cartString= json.encode(tempList).toString();
     prefs.setString('cartInfo', cartString);//
     await getListInfo(context);

  }




  

}