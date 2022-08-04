import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/pay_method.dart';
import './pay_method_count.dart';
// import 'package:provide/provide.dart';
import '../../provide/delivery_addr.dart';
import 'package:provider/provider.dart';


class PayMethodItem extends StatelessWidget {
  final PayMethodMode item;
  PayMethodItem(this.item);

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
            _itemCheckBt(context,item),
            // _itemImage(item),
            _itemName(item),
           // _itemPrice(context,item)
          ],
        ),
      );
  }
  //多选按钮
  Widget _itemCheckBt(context,item){
    return Container(
      child: Checkbox(
        value: false,
        activeColor:Colors.pink,
        onChanged: (val){

          // item.isCheck=val;
          // Provider.of<DeliveryAddrProvide>(context, listen: false).changeCheckState(item);

        },
      ),
    );
  }
  //商品图片 
  Widget _itemImage(item){
    
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color:Colors.black12)
      ),
      child:
      Text('${item.pay_name}'),
    );
  }
  //商品名称
  Widget _itemName(item){
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.pay_name),
         // CartCount(item)
        ],
      ),
    );
  }

  //商品价格
  Widget _itemPrice(context,item){

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

}