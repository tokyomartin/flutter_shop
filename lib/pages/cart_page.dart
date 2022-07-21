import 'package:flutter/material.dart';
import 'package:flutter_shop/config/api_service.dart';
// import 'package:provide/provide.dart';
import '../provide/cart.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';

import 'package:provider/provider.dart';


class CartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:Icon(Icons.arrow_back),
          onPressed: (){
            print('返回上一页');
            //Navigator.pop(context);
            // Navigator.popAndPushNamed(context, "HomePage");
            Navigator.popAndPushNamed(context, "/");
          },
        ),
        title: Text('购物车页面'),
      ),
      body: FutureBuilder(
        future:_getCartInfo(context),
        builder: (context,snapshot){
          List cartList= Provider.of<CartProvide>(context, listen: false) .cartList;
          if(snapshot.hasData && cartList!=null){
              return Stack(
                children: <Widget>[

                  Consumer<CartProvide>(
                   
                    builder: (context, CartProvide childCategory, child){
                      cartList = Provider.of<CartProvide>(context, listen: false).cartList;
                      debugPrint("---------初始化购物车---------");
                      print(cartList);
                      return ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context,index){
                          return CartItem(cartList[index]);
                        },
                      );
                    }
                  ), 
                  Positioned(
                    bottom:0,
                    left:0,
                    child: CartBottom(),
                  )
                ],
              );
        

          }else{
            return Text('正在加载');
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async{

    debugPrint("-----------进入购物车页面----------");
      await Provider.of<CartProvide>(context, listen: false).getCartInfo(context);
     return 'end';
  }

  
}