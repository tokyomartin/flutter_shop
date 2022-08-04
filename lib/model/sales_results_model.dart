
import 'package:flutter/foundation.dart';

class SalesResultsModel{

  String id;
  String? distributor_id;
  String order_id;
  String product_id;
  String product_name;
  String? cn_product_name;
  String member_id;
  String? member_code;
  String? sales_code;
  String? credit_settlement_number;
  String? customer_delivery_address_id;
  String delivery_status;
  String? card_seq;
  String? registration_date;
  String product_purchase_amount;
  String payment_sub_total;
  String? payment_shipping_fee;
  String payment_amount;
  String? payment_discount;
  String? coupon_amount;
  String? tax_amount;
  String? pay_method;
  String order_status;
  String? email;
  String? delivery_date;
  String? delivery_time_zone;


  SalesResultsModel({
    required this.id,
    this.distributor_id,
    required this.order_id,
    required this.product_id,
    required this.product_name,
    this.cn_product_name,
    required this.member_id,
    this.member_code,
    this.sales_code,
    this.credit_settlement_number,
    this.customer_delivery_address_id,
    required this.delivery_status,
    this.card_seq,
    this.registration_date,
    required this.product_purchase_amount,
    required this.payment_sub_total,
    this.payment_shipping_fee,
    required this.payment_amount,
    this.payment_discount,
    this.coupon_amount,
    this.tax_amount,
    this.pay_method,
    required  this.order_status,
    this.email,
    this.delivery_date,
    this.delivery_time_zone,
  });

  factory SalesResultsModel.fromJson(Map<String, dynamic> json) {

    return SalesResultsModel(
        id : json['id'].toString(),
        distributor_id : json['distributor_id'].toString(),
    order_id : json['order_id'].toString(),
    product_id : json['product_id'].toString(),
    product_name : json['product_name'].toString(),
    cn_product_name : json['cn_product_name'].toString(),
    member_id : json['member_id'].toString(),
    member_code : json['member_code'].toString(),
    sales_code : json['sales_code'].toString(),
    credit_settlement_number : json['credit_settlement_number'].toString(),
    customer_delivery_address_id : json['customer_delivery_address_id'].toString(),
    delivery_status : json['delivery_status'].toString(),
    card_seq : json['card_seq'].toString(),
    registration_date : json['registration_date'].toString(),
    product_purchase_amount : json['product_purchase_amount'].toString(),
    payment_sub_total : json['payment_sub_total'].toString(),
    payment_shipping_fee : json['payment_shipping_fee'].toString(),
    payment_amount : json['payment_amount'].toString(),
    payment_discount : json['payment_discount'].toString(),
    coupon_amount : json['coupon_amount'].toString(),
    tax_amount : json['tax_amount'].toString(),
    pay_method : json['pay_method'].toString(),
    order_status : json['order_status'].toString(),
    email : json['email'].toString(),
    delivery_date : json['delivery_date'].toString(),
    delivery_time_zone : json['delivery_time_zone'].toString(),
    );


  }
}
