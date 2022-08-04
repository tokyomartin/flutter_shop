import 'package:flutter/foundation.dart';

import 'product.dart';

class DetailsModel {
  final String code;
  final String message;
  final DetailsGoodsData? data;

  DetailsModel({
    required this.code,
    required this.message,
    required DetailsGoodsData data,
  }): data = data;
      //?? new DetailsGoodsData(product: null, goodComments: null, advertesPicture: null);

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    dynamic code = json['code'];
    dynamic message = json['message'];
    dynamic data = json['data'] != null ? new DetailsGoodsData.fromJson(json['data']) : null;

    debugPrint("--------▲▲▲ message:" + message.toString());
    debugPrint("--------▲▲▲ data:" + data.toString() );
    //debugPrint("--------商品详细内容:");


    return DetailsModel(
        code: code,
        message: message,
        data: data
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class DetailsGoodsData {
   Product? product;
   List<GoodComments>? goodComments;
   AdvertesPicture? advertesPicture;

  DetailsGoodsData({
     this.product,
     this.goodComments,
     this.advertesPicture,
  });

  factory DetailsGoodsData.fromJson(Map<String, dynamic> json) {
    dynamic product = json['product'] != null
        ? new Product.fromJson(json['product'])
        : null;
    dynamic goodComments;
    if (json['goodComments'] != null) {
      goodComments =  <GoodComments>[];
      json['goodComments'].forEach((v) {
        goodComments.add(new GoodComments.fromJson(v));
      });
    }
    dynamic advertesPicture = json['advertesPicture'] != null
        ? new AdvertesPicture.fromJson(json['advertesPicture'])
        : null;

    return DetailsGoodsData(
      product        : product,
      goodComments   : goodComments,
      advertesPicture  : advertesPicture,
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product?.toJson();
    }
    if (this.goodComments != null) {
      data['goodComments'] = this.goodComments?.map((v) => v.toJson()).toList();
    }
    if (this.advertesPicture != null) {
      data['advertesPicture'] = this.advertesPicture?.toJson();
    }
    return data;
  }
}



class GoodComments {
   int   ? sCORE;
   String? comments;
   String? userName;
   int   ? discussTime;

  GoodComments({
     this.sCORE,
     this.comments,
     this.userName,
     this.discussTime,

  });

  factory GoodComments.fromJson(Map<String, dynamic> json) {
    return  GoodComments(
      sCORE : json['sCORE'],
      comments : json['comments'],
      userName : json['userName'],
      discussTime : json['discussTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SCORE'] = this.sCORE;
    data['comments'] = this.comments;
    data['userName'] = this.userName;
    data['discussTime'] = this.discussTime;
    return data;
  }
}

class AdvertesPicture {
    String? pICTUREADDRESS;
    String? tOPLACE;

  AdvertesPicture({
     this.pICTUREADDRESS,
     this.tOPLACE
  });

  factory AdvertesPicture.fromJson(Map<String, dynamic> json) {

    return AdvertesPicture(
        pICTUREADDRESS : json['PICTURE_ADDRESS'],
        tOPLACE : json['TO_PLACE'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.pICTUREADDRESS;
    data['TO_PLACE'] = this.tOPLACE;
    return data;
  }
}
