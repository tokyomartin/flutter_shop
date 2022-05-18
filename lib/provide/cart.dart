import 'package:flutter/material.dart';
import 'package:flutter_shop/config/api_service.dart';
import 'package:flutter_shop/util/m_net.dart';
import 'package:flutter_shop/util/share_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cartInfo.dart';
import '../util/share_pref.dart';

import 'dart:convert';

class CartProvide with ChangeNotifier{

  String cartString="[]";
  List<CartInfoMode> cartList=[]; //商品列表对象

  double allPrice =0 ;   //总价格
  int allGoodsCount =0;  //商品总数量
  bool isAllCheck= true; //是否全选

  add(product_id, quantity, general_price, current_price,  BuildContext context) async{

    final Map<String, dynamic> params = new Map<String, dynamic>();

    var member_id = await SharePref.getSharePrefMemberId(context);

    params['member_id'] = member_id;
    params['product_id'] = product_id;
    params['quantity'] = quantity;

    MNet.getPostData(ApiService.mall_add_cart_url, params).then((response) {

      debugPrint("DetailPage提交到购物车接口");
      debugPrint(response.toString());
      debugPrint("DetailPage购物车 商品数量");
      // this.allGoodsCount += quantity;
      // this.allPrice += current_price * quantity;
      // debugPrint(this.allGoodsCount.toString());

    });

    debugPrint("DetailPage结束 购物车");
    await getCartInfo(  context );
    //notifyListeners();

  }

    save(product_id, product_name, quantity, price, small_pic) async{
    //初始化SharedPreferences
    // SharedPreferences prefs = await  SharedPreferences.getInstance();
    // cartString=prefs.getString('cartInfo');  //获取持久化存储的值
    // var temp=cartString==null?[]:json.decode(cartString.toString());
    //把获得值转变成List

    // List<Map> tempList= (temp as List).cast();
    // //声明变量，用于判断购物车中是否已经存在此商品ID
    // var isHave= false;  //默认为没有
    // int ival=0; //用于进行循环的索引使用
    // allPrice=0;
    // allGoodsCount=0;  //把商品总数量设置为0
    // tempList.forEach((item){//进行循环，找出是否已经存在该商品
    //   //如果存在，数量进行+1操作
    //   if(item['product_id']== product_id){
    //     tempList[ival]['quantity']=item['quantity']+1;
    //     cartList[ival].quantity++;
    //     isHave=true;
    //   }
    //   if(item['checked']){
    //      allPrice+= (cartList[ival].price* cartList[ival].quantity);
    //      allGoodsCount+= cartList[ival].quantity;
    //   }
    //   ival++;
    // });
    // //  如果没有，进行增加
    // if(!isHave){
    //   Map<String, dynamic> newGoods={
    //     'product_id':product_id,
    //     'product_name':product_name,
    //     'quantity':quantity,
    //     'price':price,
    //     'small_pic':small_pic,
    //     'checked': true  //是否已经选择
    //   };
    //   tempList.add(newGoods);
    //   cartList.add(new CartInfoMode.fromJson(newGoods));
    //   allPrice+= (quantity * price);
    //   allGoodsCount+=quantity;
    // }
    // //把字符串进行encode操作，
    // cartString= json.encode(tempList).toString();
    //
    // prefs.setString('cartInfo', cartString);//进行持久化


    notifyListeners();
  }


  //删除购物车中的商品
  remove() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    cartList=[];
    allPrice =0 ;
    allGoodsCount=0;
    print('清空完成-----------------');
    notifyListeners();
  }

  //得到购物车中的商品
  getCartInfo(BuildContext context) async {

    //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);

    //  //获得购物车中的商品,这时候是一个字符
    var member_id = "";
    final Map<String, dynamic> params = new Map<String, dynamic>();

    debugPrint("购物车列表接口");
    debugPrint("1.1 getCartInfo购物车列表member_id");
    member_id = await SharePref.getSharePrefMemberId(context);
    params['member_id'] = member_id.toString();


    cartList = [];
    //oauthPost
    await MNet.getPostData(ApiService.mall_get_cart_info_url, params).then((val) {

      debugPrint("params");
      debugPrint("1.2 提交到购物车接口");
      debugPrint(val.toString());
      debugPrint("1.3 getCartInfo结束");
      var data = val;
      List<Map> myList = (data['data'] as List).cast();
      debugPrint("1.3 getCartInfo List");

      this.allGoodsCount =  0;
      this.allPrice = 0;
      myList.forEach((item) {
        debugPrint(item.toString());
        // 购物车图片ID转换一下
        // item['small_pic'] = item['small_pic'];
        var cartItem = new CartInfoMode.fromJson(item);
        debugPrint("1.4 getCartInfo cartItem");
        cartList.add(cartItem);

         this.allGoodsCount +=  cartItem.quantity;
         this.allPrice += cartItem.price * cartItem.quantity;

      });
      debugPrint("1.4 getCartInfo cartItem END");
      notifyListeners();
    });
      debugPrint("getCartInfo结束 购物车2");
  }

  //删除单个购物车商品
  deleteOneGoods( BuildContext context, int product_id) async{

     // SharedPreferences prefs = await SharedPreferences.getInstance();
     // cartString=prefs.getString('cartInfo');
     // List<Map> tempList= (json.decode(cartString.toString()) as List).cast();

     final Map<String, dynamic> params = new Map<String, dynamic>();
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

     var member_id =  await SharePref.getSharePrefMemberId(context);
     params['member_id'] = member_id;
     debugPrint("购物车删除接口");

     // if(sharedPreferences.getString("user_id") != null) {
     //   // data['member_id'] = int.parse(sharedPreferences.getString("member_id"));
     //   params['user_id'] =  sharedPreferences.getString("user_id");
     // }else{
     //   debugPrint("购物车删除接口");
     // }


     debugPrint("--------1.1 deleteOneGoods ");
     debugPrint(params['member_id']);
     params['product_id']= product_id;

     cartList = [];

     //oauthPost
     await MNet.getPostData(ApiService.mall_del_cart_info_url, params).then((val) {
       debugPrint("1.2 提交到购物车删除接口");
       debugPrint(val.toString());
       debugPrint("1.3 购物车删除接口结束");
       var data = val;

       this.allPrice = 0;
       this.allGoodsCount = 0;

       debugPrint("-----{data['data'] }");

       if( 1 == data['code'] ) {

         int tempIndex = 0;
         int delIndex = 0;
         cartList.forEach((item) {
           if (item.product_id == product_id) {
             delIndex = tempIndex;
           }else{
             // this.allGoodsCount +=  item.quantity;
             // this.allPrice += item.price * item.quantity;
           }
           tempIndex++;
         });
         cartList.removeAt(delIndex);
       }
       debugPrint("1.4 购物车删除 ");
       debugPrint(cartList.toString());
       //  cartString= json.encode(tempList).toString();
       //  prefs.setString('cartInfo', cartString);//
     });
     await getCartInfo(context);
     //notifyListeners();
  }

  //修改选中状态
  changeCheckState( BuildContext context, CartInfoMode cartItem) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     cartString=prefs.getString('cartInfo'); 
     List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
     int tempIndex =0;
     int changeIndex=0;
     tempList.forEach((item){
         
         if(item['product_id']==cartItem.product_id){
          changeIndex=tempIndex;
         }
         tempIndex++;
     });
     tempList[changeIndex]=cartItem.toJson();
     cartString= json.encode(tempList).toString();
     prefs.setString('cartInfo', cartString);//
     await getCartInfo(context);
  }

  //点击全选按钮操作
  changeAllCheckBtnState(BuildContext context, bool isCheck) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo'); 
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    List<Map> newList=[];
    for(var item in tempList ){
      var newItem = item;
      newItem['checked']=isCheck;
      newList.add(newItem);
    } 
   
     cartString= json.encode(newList).toString();
     prefs.setString('cartInfo', cartString);//
     await getCartInfo( context );

  }

  //增加减少数量的操作

  addOrReduceAction(BuildContext context, var cartItem, String todo )async{
      final Map<String, dynamic> params = new Map<String, dynamic>();


      var member_id =  await SharePref.getSharePrefMemberId(context);
      params['member_id'] = member_id;


      debugPrint("--------1.1 addOrReduceAction ");

      var product_id = cartItem.product_id;


      params['product_id']= product_id;
      // cartList = [];
       if(todo=='add'){
         cartItem.quantity++;
       }else if( cartItem.quantity > 1){
         cartItem.quantity--;
       }else{

       }

      params['quantity'] = cartItem.quantity;
      debugPrint(params.toString());
      //oauthPost
      await MNet.getPostData(ApiService.mall_update_cart_info_url, params).then((val) {
        debugPrint("1.2 addOrReduceAction 提交到购物车商品数量接口");
        debugPrint(val.toString());
        debugPrint("1.3 addOrReduceAction 购物车商品数量接口结束");
        var data = val;

        debugPrint("-----{data['data']}");

        if (1 == data['code']) {

          // int tempIndex = 0;
          // int delIndex = 0;
          //
          // cartList.forEach((item) {
          //   if (item.product_id == product_id) {
          //     delIndex = tempIndex;
          //   }
          //   tempIndex++;
          // });
          // cartList.removeAt(delIndex);

        }
        debugPrint("1.4 addOrReduceAction 购物车修改商品数量 ");
        debugPrint(cartList.toString());
        //  cartString= json.encode(tempList).toString();
        //  prefs.setString('cartInfo', cartString);//

      });

      await getCartInfo( context);
      //notifyListeners();

    }




  

}