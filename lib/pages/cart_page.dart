import 'package:flutter/material.dart';
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
        title: Text('购物车'),
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
     await Provider.of<CartProvide>(context, listen: false).getCartInfo();
     return 'end';
  }

  
}