import 'package:flutter/material.dart';
// import 'package:provide/provide.dart';
import '../provide/delivery_addr.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';

import 'package:provider/provider.dart';


//TODO @deprecated 不使用  可以删掉

class CartConfirmPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车确认页'),
      ),
      body: FutureBuilder(
        future:_getCartInfo(context),
        builder: (context,snapshot){
          List cartList= Provider.of<DeliveryAddrProvide>(context, listen: false) .DeliveryAddrList;
          if(snapshot.hasData && cartList!=null){
              return Stack(
                children: <Widget>[

                  Consumer<DeliveryAddrProvide>(
                   
                    builder: (context, DeliveryAddrProvide childCategory, child){
                      cartList = Provider.of<DeliveryAddrProvide>(context, listen: false).DeliveryAddrList;
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
     await Provider.of<DeliveryAddrProvide>(context, listen: false).getListInfo(context);
     return 'end';
  }

  
}