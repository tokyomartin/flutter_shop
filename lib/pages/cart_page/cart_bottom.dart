import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provide/provide.dart';

import '../../provide/cart.dart';


import 'package:provider/provider.dart';

import '../cart_to_confirm_page.dart';


class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Consumer<CartProvide>(
        builder: (context, CartProvide childCategory, child){
          return  Row(
            children: <Widget>[
              selectAllBtn(context),
              allPriceArea(context),
              goButton(context)
            ],
          );
        },
      )
    );
  }

  //全选按钮
  Widget selectAllBtn(context){
    bool isAllCheck = Provider.of<CartProvide>(context, listen: false).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.pink,
            onChanged: (bool val){
              Provider.of<CartProvide>(context, listen: false).changeAllCheckBtnState(  context, val);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  // 合计区域
  Widget allPriceArea(context){
    double allPrice = Provider.of<CartProvide>(context, listen: false).allPrice;
   
    return Container(
      width: ScreenUtil().setWidth(430),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计:',
                  style:TextStyle(
                    fontSize: ScreenUtil().setSp(36)
                  )
                ), 
              ),
              Container(
                 alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  '￥${allPrice}',
                  style:TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                    color: Colors.red,
                  )
                ),
                
              )
             
              
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(22)
              ),
            ),
          )
          
        ],
      ),
    );

  }

  //结算按钮
  Widget goButton(context){
    int allGoodsCount =  Provider.of<CartProvide>(context, listen: false).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child:InkWell(
        onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context){ return CartToConfirmPage();}));
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
             color: Colors.red,
             borderRadius: BorderRadius.circular(3.0)
          ),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ) ,
    );
    
  
  }

}