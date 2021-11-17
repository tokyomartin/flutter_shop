import 'package:flutter/material.dart';
// import 'package:provide/provide.dart';
import '../provide/pay_method.dart';
// import './cart_page/cart_item.dart';
import './pay_method_page/pay_method_bottom.dart';

import 'package:provider/provider.dart';

import 'pay_method_page/pay_method_item.dart';


class PayMethodPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('支付方式'),
      ),
      body: FutureBuilder(
        future:_getDataInfo(context),
        builder: (context,snapshot){
          List myDataList= Provider.of<PayMethodProvide>(context, listen: false).myDataList;
          if(snapshot.hasData && myDataList!=null){
              return Stack(
                children: <Widget>[

                  Consumer<PayMethodProvide>(
                   
                    builder: (context, PayMethodProvide itemProvide, child){

                      myDataList = Provider.of<PayMethodProvide>(context, listen: false).myDataList;
                      //print(cartList);

                      debugPrint('---item----');
                      debugPrint(myDataList.length.toString());

                      return ListView.builder(
                        itemCount: myDataList.length,
                        itemBuilder: (context,index){
                          return PayMethodItem(myDataList[index]);
                        },
                      );
                    }
                  ), 
                  Positioned(
                    bottom:0,
                    left:0,
                    child: PayMethodBottom(),
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

  Future<String> _getDataInfo(BuildContext context) async{
     await Provider.of<PayMethodProvide>(context, listen: false).getListInfo(context);
     return 'end';
  }

  
}