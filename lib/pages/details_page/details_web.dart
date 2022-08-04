import 'package:flutter/material.dart';
// import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

class DetailsWeb extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {


    // var goodsDetail = Provider.of<DetailsInfoProvide>(context, listen: false).goodsInfo.data.goodInfo.goodsDetail;
    var discription = Provider.of<DetailsInfoProvide>(context, listen: false).detailResult?.data?.product?.discription;

    //Provider.of<DetailsInfoProvide>(context, listen: false)

   
      return Consumer<DetailsInfoProvide>(
        builder: (context,DetailsInfoProvide val, child){
           var isLeft = Provider.of<DetailsInfoProvide>(context, listen: false).isLeft;
           if(isLeft){
             return  Container(
                  child: Html(
                    data:discription
                  ),
              );
           }else{
            return Container(
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child:Text('暂时没有数据')
            );
           }
        },
      );
      
  }
}