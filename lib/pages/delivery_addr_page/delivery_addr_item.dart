import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/api_service.dart';
import 'package:flutter_shop/util/m_net.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/delivery_addr.dart';
import './cart_count.dart';
// import 'package:provide/provide.dart';
import '../../provide/delivery_addr.dart';
import 'package:provider/provider.dart';


class DeliveryAddrItem extends StatelessWidget {
  final DeliveryAddrMode item;
  DeliveryAddrItem(this.item);


  @override
  Widget build(BuildContext context) {
    print(item);
    return Container(
        margin: EdgeInsets.fromLTRB(5.0,2.0,5.0,2.0),
        padding: EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width:1,color:Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            //_cartCheckBt(context,item),
            _deliveryAddrPostCode(item),
            _deliveryAddrName(item),
            //_deliveryUser(context,item),
            _deliverySetDefault(context,item)
          ],
        ),
      );
  }
  //多选按钮
  Widget _cartCheckBt(context,item){
    return Container(
      child: Checkbox(
        value: false,
        activeColor:Colors.pink,
        onChanged: (bool val){

          // item.isCheck=val;
          // Provider.of<DeliveryAddrProvide>(context, listen: false).changeCheckState(item);

        },
      ),
    );
  }
  //商品图片 
  Widget _deliveryAddrPostCode(item){
    
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color:Colors.black12)
      ),
      child:
      Text('${item.post_code_front} - ${item.post_code_back}'),
    );
  }
  //商品名称
  Widget _deliveryAddrName(item){

    var is_default_text = "";
    if(item.is_default == 1){

      is_default_text = "默认收货地址";
      // this.delivery_addr_id = item.id;

    }


    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.prefecture + " " + item.city + " " + item.address1 ),
          // Text('收件人：'),
          Text('${item.last_name} ${item.first_name}'),
          Text(is_default_text, style: TextStyle(color:Colors.red),),
         // CartCount(item)
        ],
      ),
    );
  }

  //商品价格
  Widget _deliveryUser(context,item){

    return Container(
        width:ScreenUtil().setWidth(150) ,
        alignment: Alignment.centerRight,
        
        child: Column(
          children: <Widget>[
            Text('${item.last_name} ${item.first_name}'),
            Container(
              child: InkWell(
                onTap: (){

                  // Provider.of<DeliveryAddrProvide>(context, listen: false).deleteOneGoods(item.product_id);

                },
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.black26,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      );
  }

  //商品价格
  Widget _deliverySetDefault(context,item){

    return Container(
      width:ScreenUtil().setWidth(150) ,
      alignment: Alignment.centerRight,

      child: Column(
        children: <Widget>[
          Text('设为默认收货地址'),
          Container(
            child: InkWell(
              onTap: (){
                 Provider.of<DeliveryAddrProvide>(context, listen: false).setDefault(context,  item.member_id, item.id);

                  //Navigator.pop(context,'1号编号：123'); //第2个参数是返回的参数

                 // widget.delivery_addr_id = item.id;

                 Navigator.pop(context,'${item.id}:${item.prefecture}${item.city}${item.address1}'); //第2个参数是返回的参数



              },
              child: Icon(
                Icons.home,
                color: Colors.black26,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

}