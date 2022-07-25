import 'package:flutter/material.dart';
import 'package:flutter_shop/config/api_service.dart';
import 'package:flutter_shop/model/delivery_addr.dart';
import 'package:flutter_shop/util/m_net.dart';
import 'package:flutter_shop/util/share_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';
import '../model/cartInfo.dart';

import '../model/delivery_addr.dart';

import 'dart:convert';

class DeliveryAddrProvide with ChangeNotifier{

  List<DeliveryAddrMode> DeliveryAddrList=[]; //商品列表对象

  double allPrice =0 ;   //总价格
  int allGoodsCount =0;  //商品总数量
  bool isAllCheck= true; //是否全选


  save(member_id, post_code_front, post_code_back, prefecture, city, address1, last_name, first_name, last_name_kana, first_name_kana, phone_number, company_name, is_default) async{
    //初始化SharedPreferences

    //声明变量，用于判断购物车中是否已经存在此商品ID
    //  如果没有，进行增加
    //deliveryAddrMode

      Map<String, dynamic> params={
        'member_id':member_id,
        'post_code_front':post_code_front,
        'post_code_back':post_code_back,
        'prefecture':prefecture,
        'city':city,
        'address1':address1,
        'last_name':last_name,
        'first_name':first_name,
        'last_name_kana':last_name_kana,
        'first_name_kana':first_name_kana,
        'company_name':company_name,
        'phone_number': phone_number,  //是否已经选择
        'is_default': is_default,
      };

      //oauthPost
      await MNet.getPostData(ApiService.mall_delivery_addr_add_url, params).then((val) async {

        debugPrint("1.2 提交到订单接口");
        debugPrint(val.toString());
        debugPrint("1.3 DeliveryAddrProvide result");
        debugPrint(val['result']);
        var myresult = val['result'];
        print(myresult.runtimeType);
        debugPrint("1.3 DeliveryAddrProvide code");
        debugPrint(val['result']);

        if(val['result'] == 'true'){

          Fluttertoast.showToast(
              msg: "提交成功！",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          return true;
        }else{

          Fluttertoast.showToast(
              msg: "提交失败！",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          return false;
        }
      });

      // tempList.add(newGoods);
      //DeliveryAddrList.add(new DeliveryAddrMode.fromJson(deliveryAddrMode));

      notifyListeners();
  }


  //删除购物车中的商品
  remove() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    DeliveryAddrList=[];
    allPrice =0 ;
    allGoodsCount=0;
    print('清空完成-----------------');
    notifyListeners();
  }

  //得到购物车中的商品
  getListInfo(BuildContext context) async {

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['member_id']  = await SharePref.getSharePrefMemberId(context);

     await MNet.oauthGet(ApiService.user_delivery_addr_url, data).then((val) {

       DeliveryAddrList = [];
       debugPrint("提交到 送货地址接口");
       debugPrint(val.toString());

       var data = val;
       List<Map> myList = (data['data'] as List).cast();
       myList.forEach((item) {
         debugPrint(item.toString());
         DeliveryAddrList.add(new DeliveryAddrMode.fromJson(item));
       });
     });

     debugPrint("结束 送货地址接口");


     // await Provider.of<CartProvide>(context, listen: false).save(goodsID,goodsName,count,price,images);
     // await Provider.of<DeliveryAddrProvide>(context, listen: false).save(id,product_name,quantity,general_price,images);

     //获得购物车中的商品,这时候是一个字符串
     // cartString=prefs.getString('cartInfo');

      notifyListeners();
  }

  //删除单个购物车商品
  deleteOneGoods(BuildContext context, int product_id) async{

     // int tempIndex =0;
     // int delIndex=0;
     // tempList.forEach((item){
     //
     //     if(item['product_id']==product_id){
     //      delIndex=tempIndex;
     //     }
     //     tempIndex++;
     // });
     //  tempList.removeAt(delIndex);
     //  cartString= json.encode(tempList).toString();
     //  prefs.setString('cartInfo', cartString);//
     //  await getListInfo(context);
     

  }

  setDefault(BuildContext context, member_id, id){
    Map<String, dynamic> params={
      'member_id': member_id,
      'id': id,
    };
    //oauthPost
    MNet.getPostData(ApiService.mall_delivery_addr_set_default_url, params).then((val) async {

      debugPrint("setDefault");
      // debugPrint(val.toString());
      // var myresult = val['result'];
      // print(myresult.runtimeType);
      // debugPrint(val['result']);

      if(val['result'] == 'true'){

        Fluttertoast.showToast(
            msg: "设置默认邮寄地址成功！",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );


        //return true;
      }else{

        Fluttertoast.showToast(
            msg: "提交失败！",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        //return false;
      }

      await getListInfo(context);
      //notifyListeners();

    });


  }



  //修改选中状态
  changeCheckState(BuildContext context, CartInfoMode cartItem) async{

     // SharedPreferences prefs = await SharedPreferences.getInstance();
     //
     // int tempIndex =0;
     // int changeIndex=0;
     // tempList.forEach((item){
     //
     //     if(item['product_id']==cartItem.product_id){
     //      changeIndex=tempIndex;
     //     }
     //     tempIndex++;
     // });
     // tempList[changeIndex]=cartItem.toJson();
     // cartString= json.encode(tempList).toString();
     // prefs.setString('cartInfo', cartString);//
     // await getListInfo(context);
    
  }

  //点击全选按钮操作
  changeAllCheckBtnState(BuildContext context, bool isCheck) async{

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // cartString=prefs.getString('cartInfo');
    // List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    // List<Map> newList=[];
    // for(var item in tempList ){
    //   var newItem = item;
    //   newItem['isCheck']=isCheck;
    //   newList.add(newItem);
    // }
    //
    //  cartString= json.encode(newList).toString();
    //  prefs.setString('cartInfo', cartString);//
    //  await getListInfo(context);

  }






  

}