import 'package:flutter/material.dart';
// import 'package:provide/provide.dart';
import '../provide/location.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';

import 'package:provider/provider.dart';

//Location List
// 不用

class LocationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LBS首页'),
      ),
      body: FutureBuilder(
        future:_getCartInfo(context),
        builder: (context,snapshot){
          List locationList= Provider.of<LocationProvide>(context, listen: false).getList(context);
          if(snapshot.hasData && locationList!=null){
              return Stack(
                children: <Widget>[

                  Consumer<LocationProvide>(
                   
                    builder: (context, LocationProvide childCategory, child){
                      locationList = Provider.of<LocationProvide>(context, listen: false).getList(context);
                      debugPrint("---------初始化店铺列表---------");
                      print(locationList);
                      return ListView.builder(
                        itemCount: locationList.length,
                        itemBuilder: (context,index){
                          return CartItem(locationList[index]);
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
      // await Provider.of<LocationProvide>(context, listen: false).getCartInfo(context);
     return 'end';
  }

  
}