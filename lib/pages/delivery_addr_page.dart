import 'package:flutter/material.dart';
// import 'package:provide/provide.dart';
import '../provide/delivery_addr.dart';

// import './cart_page/cart_item.dart';

import './delivery_addr_page/delivery_addr_bottom.dart';

import 'package:provider/provider.dart';

import 'delivery_addr_page/delivery_addr_item.dart';


class DeliveryAddrPage extends StatelessWidget {


var delivery_addr_id;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('送货地址'),
      ),
      body: FutureBuilder(
        future:_getDeliveryAddrInfo(context),
        builder: (context,snapshot){
          List cartList= Provider.of<DeliveryAddrProvide>(context, listen: false).DeliveryAddrList;
          if(snapshot.hasData && cartList!=null){
              return Stack(
                children: <Widget>[

                  Consumer<DeliveryAddrProvide>(
                   
                    builder: (context, DeliveryAddrProvide itemProvide, child){

                      cartList = Provider.of<DeliveryAddrProvide>(context, listen: false).DeliveryAddrList;
                      //print(cartList);

                      debugPrint('---delivery addr item----');
                      debugPrint(cartList.length.toString());

                      return ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context,index){
                          return DeliveryAddrItem(cartList[index]);
                        },
                      );
                    }
                  ), 
                  Positioned(
                    bottom:0,
                    left:0,
                    child: DeliveryAddrBottom(),
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

  Future<String> _getDeliveryAddrInfo(BuildContext context) async{
     await Provider.of<DeliveryAddrProvide>(context, listen: false).getListInfo(context);
     return 'end';
  }

  
}