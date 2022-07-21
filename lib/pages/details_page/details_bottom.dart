import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/api_service.dart';
import 'package:flutter_shop/util/http.dart';
import 'package:flutter_shop/util/m_net.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:provide/provide.dart';
import '../../login.dart';
import '../../provide/cart.dart';
import '../../provide/details_info.dart';
import '../../provide/currentIndex.dart';

import 'package:provider/provider.dart';

import '../cart_page.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

     var product= Provider.of<DetailsInfoProvide>(context, listen: false).detailResult.data.product;
     // var goodsInfo= Provider.of<DetailsInfoProvide>(context, listen: false).goodsInfo;

     debugPrint("goodsInfo内容");
     debugPrint(product.toString());

    // var goodsID= goodsInfo.goodsId;
    // var goodsName =goodsInfo.goodsName;
     var id= product.id;
     var product_name =product.product_name;

     // var goodsID= goodsInfo["id"];
     // var goodsName =goodsInfo["product_name"];
    var count =1;
    // var price =goodsInfo.presentPrice;
    // var images= goodsInfo.image1;
     // var price =goodsInfo.presentPrice;
     // var images= goodsInfo['small_img_url'];
     var general_price =product.general_price;
     var current_price =product.current_price;

     //TODO small_img_url
     // var images= goodsInfo.small_img_url;
     // var price =goodsInfo["general_price"];
     var image_base_url = "https://skm-php.s3.us-west-1.amazonaws.com/product_images/1001/";
     var images= image_base_url + product.small_img_url;
     // var images= "http://29e5534ea20a8.cdn.sohucs.com/c_cut,x_178,y_20,w_1021,h_680,c_zoom,h_103/os/news/4b39a1b8656ef59d99a3a5d827fe5fd1.jpg";

     return Container(
       width:ScreenUtil().setWidth(750),
       color: Colors.white,
       height: ScreenUtil().setHeight(80),
       child: Row(
         children: <Widget>[
           Stack(
             children: <Widget>[
               InkWell(
                  onTap: (){

                    debugPrint("--打开购物车页面");
                    Provider.of<CurrentIndexProvide>(context, listen: false).changeIndex(2);
                      Navigator.pop(context);
                  },
                  child: Container(
                      width: ScreenUtil().setWidth(110) ,
                      alignment: Alignment.center,
                      child:Icon(
                            Icons.shopping_cart,
                            size: 35,
                            color: Colors.red,
                          ), 
                    ) ,
                ),
                  Consumer<CartProvide>(
                  builder: (context, CartProvide val, child){
                    int  goodsCount = Provider.of<CartProvide>(context, listen: false).allGoodsCount;
                    return  Positioned(
                        top:0,
                        right: 10,
                        child: Container(
                          padding:EdgeInsets.fromLTRB(6, 3, 6, 3),
                          decoration: BoxDecoration(
                            color:Colors.pink,
                            border:Border.all(width: 2,color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0)
                          ),
                          child: Text(
                            '${goodsCount}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(22)
                            ),
                          ),
                        ),
                      ) ;
                  },
                )
              
             ],
           ),
          
           InkWell(
            onTap: ()async {

              debugPrint("加入购物车");
              debugPrint(id.toString() + ":" + product_name);
              // var member_id = '10006974';
              // var product_id = id;
              var quantity = 1;


              // data['product_id'] = id;
              // data['quantity'] = quantity;
              // await Provider.of<CartProvide>(context, listen: false).save(goodsID,goodsName,count,price,images);
              await Provider.of<CartProvide>(context, listen: false).add(id, quantity,  general_price, current_price, context);


            },
             child: Container(
               alignment: Alignment.center,
               width: ScreenUtil().setWidth(320),
               height: ScreenUtil().setHeight(80),
               color: Colors.green,
               child: Text(
                 '加入购物车',
                 style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),
               ),
             ) ,
           ),

           // 原来是 马上购买  暂时去掉
           //  改成去购物车
           InkWell(
             onTap: ()async{
                 // await Provider.of<CartProvide>(context, listen: false).remove();
               //销毁当前页面 只剩下后面的画面
               //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => CartPage()), (Route<dynamic> route) => false);
               Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CartPage()));

             },
             child: Container(
               alignment: Alignment.center,
               width: ScreenUtil().setWidth(320),
               height: ScreenUtil().setHeight(80),
               color: Colors.red,
               child: Text(
                 '查看购物车',
                 style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),
               ),
             ) ,
           ),

         ],
       ),
    );
  }
}