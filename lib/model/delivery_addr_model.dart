
import 'package:flutter/material.dart';

class DeliveryAddrModel {
   int   ? id;
   int   ? member_id;
   String? post_code_front;
   String? post_code_back;
   String? prefecture;
   String? city;
   String? address1;
   String? last_name;
   String? first_name;
   String? last_name_kana;
   String? first_name_kana;
   String? company_name;
   String? phone_number;
   int   ? is_default;



  DeliveryAddrModel(
      {
       this.id,
       this.member_id,
       this.post_code_front,
       this.post_code_back,
       this.prefecture,
       this.city,
       this.address1,
       this.last_name,
       this.first_name,
       this.last_name_kana,
       this.first_name_kana,
       this.company_name,
       this.phone_number,
       this.is_default,
      });

  factory DeliveryAddrModel.fromJson(Map<String, dynamic> json) {

    dynamic id;
    dynamic member_id;
    dynamic post_code_front;
    dynamic post_code_back;
    dynamic prefecture;
    dynamic city;
    dynamic address1;
    dynamic last_name;
    dynamic first_name;
    dynamic phone_number;
    dynamic last_name_kana;
    dynamic first_name_kana;
    dynamic company_name;
    dynamic is_default;

    debugPrint("------DeliveryAddrModel.toString()----");
    if(json != null) {
      debugPrint("------DeliveryAddrModel.id----");
      id = int.parse(json['id'].toString());
      debugPrint("------DeliveryAddrModel.member id----");
      member_id = int.parse(json['member_id'].toString());
      debugPrint("------DeliveryAddrModel.other----");
      post_code_front = json['post_code_front'].toString();
      post_code_back = json['post_code_back'].toString();
      prefecture = json['prefecture'].toString();
      city = json['city'].toString();
      address1 = json['address1'].toString();
      last_name = json['last_name'].toString();
      first_name = json['first_name'].toString();
      phone_number = json['phone_number'].toString();
      last_name_kana = json['last_name_kana'].toString();
      first_name_kana = json['first_name_kana'].toString();
      company_name = json['company_name'].toString();
      is_default = int.parse(json['is_default'].toString());

      debugPrint("------ Success end DeliveryAddrModel.toString()----");
    }else{

      debugPrint("------ERROR end DeliveryAddrModel.toString()----");
    }

    return DeliveryAddrModel(
      id : id,
      member_id : member_id,
      post_code_front : post_code_front,
      post_code_back : post_code_back,
      prefecture : prefecture,
      city : city,
      address1 : address1,
      last_name : last_name,
      first_name : first_name,
      phone_number : phone_number,
      last_name_kana : last_name_kana,
      first_name_kana : first_name_kana,
      company_name : company_name,
      is_default : is_default,
    );

    debugPrint("------end DeliveryAddrModel.toString()----");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['member_id'] = this.member_id;
    data['post_code_front'] = this.post_code_front;
    data['post_code_back'] = this.post_code_back;
    data['prefecture'] = this.prefecture;
    data['city'] = this.city;
    data['address1']= this.address1;
    data['last_name'] = this.last_name;
    data['first_name']= this.first_name;
    data['last_name_kana'] = this.last_name_kana;
    data['first_name_kana']= this.first_name_kana;
    data['company_name']= this.company_name;
    data['phone_number']= this.phone_number;
    data['is_default']= this.is_default;

    return data;
  }
}