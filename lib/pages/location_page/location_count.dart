import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provide/provide.dart';
import '../../provide/location.dart';

import 'package:provider/provider.dart';

class LocationCount extends StatelessWidget {
  var item;
  LocationCount(this.item);



  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top:5.0),
      decoration: BoxDecoration(
        border:Border.all(width: 1 , color:Colors.black12)
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(),
          _addBtn(context),
        ],
      ),
      
    );
  }
  // 减少按钮
  Widget _reduceBtn(context){
    return InkWell(
      onTap: (){
        //TODO 调用远程接口 减数量
        //Provider.of<CartProvide>(context, listen: false)
        debugPrint("-------_reduceBtn--addOrReduceAction---------");
         //TODO  Provider.of<LocationProvide>(context, listen: false).addOrReduceAction(  context , item,'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
       
        decoration: BoxDecoration(
          color: item.quantity>1?Colors.white:Colors.black12,
          border:Border(
            right:BorderSide(width:1,color:Colors.black12)
          )
        ),
        child:item.quantity>1? Text('-'):Text(' '),
      ),
    );
  }

  //添加按钮
  Widget _addBtn(context){
    return InkWell(
      onTap: (){
        debugPrint("-------_addBtn--addOrReduceAction---------");
          //TODO  Provider.of<LocationProvide>(context, listen: false).addOrReduceAction(  context, item,'add');
        //TODO 调用远程接口 加数量

      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
       
         decoration: BoxDecoration(
          color: Colors.white,
          border:Border(
            left:BorderSide(width:1,color:Colors.black12)
          )
        ),
        child: Text('+'),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea(){
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
       child: Text('${item.quantity}'),
    );
  }

}