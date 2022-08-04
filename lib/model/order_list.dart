
import 'package:flutter/widgets.dart';

import 'order.dart';
// import 'sales_results_model.dart';

class OrderListModel {


  final int    code;
  final String message;
  final String result;
  final List<OrderModel> data;
  final int    data_count;

  OrderListModel ({
    required  this.code,
    required  this.message,
    required  this.result,
    required  this.data_count,
    required  this.data
     });

  factory OrderListModel.fromJson(Map<String, dynamic> json) {

    var data = <OrderModel>[];
    if(null != json['data']){
      // sales_results
      json['data'].forEach((v) {
        debugPrint("------v.toString()----");
        debugPrint(v?.toString());
        data.add(new OrderModel.fromJson(v));
      });
    }

    return OrderListModel(
        code : json['code'],
        message : json['message'],
        result : json['result'],
        data_count : json['data_count'],
        data: data,
    );
  }

}



  
// @JsonSerializable()
//   class OrderListData extends Object with _$OrderListDataSerializerMixin{
//
//   @JsonKey(name: 'Order')
//   Order order;
//
//   @JsonKey(name: 'ProductList')
//   List<ProductList> productList;
//
//   @JsonKey(name: 'CartList')
//   List<CartList> cartList;
//
//   @JsonKey(name: 'ProductSpecsList')
//   List<ProductSpecsList> productSpecsList;
//
//   @JsonKey(name: 'Comment')
//   List<dynamic> comment;
//
//   OrderListData(this.order,this.productList,this.cartList,this.productSpecsList,this.comment,);
//
//   factory OrderListData.fromJson(Map<String, dynamic> srcJson) => _$OrderListDataFromJson(srcJson);
//
// }






  
