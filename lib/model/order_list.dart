
import 'package:flutter/widgets.dart';

import 'order.dart';
import 'sales_results_model.dart';

class OrderListModel {


  int code;
  String message;
  String result;
  List<OrderModel> data;
  int data_count;

  OrderListModel (this.code, this.message, this.data_count, this.data,t );

  OrderListModel.fromJson(Map<String, dynamic> json) {
    debugPrint("------from json1----");
    code = json['code'];
    message = json['message'];
    result = json['result'];
    data_count = json['data_count'];

    debugPrint("------from json2----");

    if(null != json['data']){
      data = new List<OrderModel>();
      // sales_results
      json['data'].forEach((v) {
        debugPrint("------v.toString()----");
        debugPrint(v.toString());
        data.add(new OrderModel.fromJson(v));
      });
    }

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






  
