
import 'package:flutter/foundation.dart';


import './sales_results_model.dart';

import './delivery_addr_model.dart';



class OrderModel {


  // Product --- order --- SalesResults

  List<SalesResultsModel> salesResultsList;

  DeliveryAddrModel member_delivery_address;

  int id;
  String order_id;
  String p_order_id;
  String shop_id;
  String member_id;
  String group_id;
  String member_code;
  String payment_amount;
  String payment_sub_total;
  String payment_shipping_fee;
  String tax_amount;
  String point_amount;
  String shop_discount;
  String discount;
  String coupon_amount;
  String pay_method;
  int order_status;
  String delivery_status;
  String receiver_first_name;
  String receiver_last_name;
  String receiver_phone;
  String post_code_front;
  String post_code_back;
  String receiver_country;
  String receiver_province;
  String receiver_city;
  String receiver_town;
  String receiver_address;
  String customer_delivery_address_id;
  String card_seq;
  String credit_settlement_number;
  String receipt_flg;
  String registration_date;
  String delivery_date;
  String delivery_time_zone;
  String delivery_opt;

  OrderModel({
    this.id,
    this.order_id,
    this.p_order_id,
    this.shop_id,
    this.member_id,
    this.group_id,
    this.member_code,
    this.payment_amount,
    this.payment_sub_total,
    this.payment_shipping_fee,
    this.tax_amount,
    this.point_amount,
    this.shop_discount,
    this.discount,
    this.coupon_amount,
    this.pay_method,
    this.order_status,
    this.delivery_status,
    this.receiver_first_name,
    this.receiver_last_name,
    this.receiver_phone,
    this.post_code_front,
    this.post_code_back,
    this.receiver_country,
    this.receiver_province,
    this.receiver_city,
    this.receiver_town,
    this.receiver_address,
    this.customer_delivery_address_id,
    this.card_seq,
    this.credit_settlement_number,
    this.receipt_flg,
    this.registration_date,
    this.delivery_date,
    this.delivery_time_zone,
    this.delivery_opt,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    debugPrint("------v.id----");
    //id = int.parse(json['id'].toString());
    id = int.parse(json['id'].toString());
    order_id = json['order_id'];
    debugPrint("------v.p orderid----");
    p_order_id = json['p_order_id'];

    shop_id = json['shop_id'].toString();

    member_id = json['member_id'].toString();

    group_id = json['group_id'].toString();

    member_code = json['member_code'].toString();

    payment_amount = json['payment_amount'].toString();

    payment_sub_total = json['payment_sub_total'].toString();

    payment_shipping_fee = json['payment_shipping_fee'].toString();

    tax_amount = json['tax_amount'].toString();
    point_amount = json['point_amount'].toString();
    shop_discount = json['shop_discount'].toString();
    discount = json['discount'].toString();
    coupon_amount = json['coupon_amount'].toString();

    pay_method = json['pay_method'].toString();
    order_status = int.parse(json['order_status'].toString());
    delivery_status = json['delivery_status'].toString();
    receiver_first_name = json['receiver_first_name'].toString();
    receiver_last_name = json['receiver_last_name'].toString();
    receiver_phone = json['receiver_phone'].toString();
    post_code_front = json['post_code_front'].toString();
    post_code_back = json['post_code_back'];

    receiver_country = json['receiver_country'];
    receiver_province = json['receiver_province'];
    receiver_city = json['receiver_city'];
    receiver_town = json['receiver_town'];
    receiver_address = json['receiver_address'];

    customer_delivery_address_id = json['customer_delivery_address_id'].toString();
    card_seq = json['card_seq'].toString();
    credit_settlement_number = json['credit_settlement_number'].toString();
    receipt_flg = json['receipt_flg'].toString();
    debugPrint("------v.receipt flg----");
    registration_date = json['registration_date'];
    delivery_date = json['delivery_date'];
    delivery_time_zone = json['delivery_time_zone'];
    delivery_opt = json['delivery_opt'];

    if(null != json['sales_results']){
      salesResultsList = new List<SalesResultsModel>();
      // sales_results
      json['sales_results'].forEach((v) {
        debugPrint("------v.sales_results----");
        //debugPrint(v.toString());
        salesResultsList.add(new SalesResultsModel.fromJson(v));
      });
    }

    if(null != json['member_delivery_address']){
      debugPrint("------v.member_delivery_address----");
      member_delivery_address = new DeliveryAddrModel.fromJson(json['member_delivery_address']);
    }else{
      member_delivery_address = new DeliveryAddrModel();
    }



  }
}
