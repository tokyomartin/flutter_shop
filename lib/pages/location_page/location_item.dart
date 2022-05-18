import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/location.dart';
import './location_count.dart';
// import 'package:provide/provide.dart';
import '../../provide/location.dart';
import 'package:provider/provider.dart';


class LocationItem extends StatelessWidget {
  final LocationMode item;
  LocationItem(this.item);

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
           _cartCheckBt(context,item),
            _cartImage(item),
            _cartGoodsName(item),
            // TODO
             _cartPrice(context,item)
          ],
        ),
      );
  }
  //多选按钮
  Widget _cartCheckBt(context,item){
    return Container(
      child: Checkbox(
        value: item.checked,
        activeColor:Colors.pink,
        onChanged: (bool val){
          item.checked=val;
          debugPrint("---------_cartCheckBt---------");
          //TODO Provider.of<LocationProvide>(context, listen: false).changeCheckState(  context, item);
        },
      ),
    );
  }
  //商品图片 
  Widget _cartImage(item){
    
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color:Colors.black12)
      ),
      child:
      Image.network(
           item.small_pic,
          // item.images,
          //item.img,
          errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
            return Text('Your error widget...');
          }
          ),
    );
  }
  //商品名称
  Widget _cartGoodsName(item){
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.product_name),
           // CartCount(item)
        ],
      ),
    );
  }

  //商品价格
  Widget _cartPrice(context,item){

    return Container(
        width:ScreenUtil().setWidth(150) ,
        alignment: Alignment.centerRight,
        
        child: Column(
          children: <Widget>[
            Text('￥${item.price}'),
            Container(
              child: InkWell(
                onTap: (){
                  debugPrint("---------deleteOneGoods---------");
                  //TODO Provider.of<LocationProvide>(context, listen: false).deleteOneGoods(  context, item.product_id);
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