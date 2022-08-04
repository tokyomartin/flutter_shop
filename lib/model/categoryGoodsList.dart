class CategoryGoodsListModel {
  String code;
  String message;
  List<CategoryListData> data;

  CategoryGoodsListModel({
    required this.code,
    required this.message,
    required List<CategoryListData> data,
  }): data = data;

  factory CategoryGoodsListModel.fromJson(Map<String, dynamic> json) {
   dynamic  code = json['code'];
   dynamic  message = json['message'];
   dynamic  data = <CategoryListData>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new CategoryListData.fromJson(v));
      });
    }
    return CategoryGoodsListModel(code: code, message: message, data: data);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryListData {
     String? image;
     double? oriPrice;
     double? presentPrice;
     String? goodsName;
     String? goodsId;

  CategoryListData(
      {
     this.image,
     this.oriPrice,
     this.presentPrice,
     this.goodsName,
     this.goodsId
      });

  factory CategoryListData.fromJson(Map<String, dynamic> json) {
     return CategoryListData(
       image : json['image'],
       oriPrice : json['oriPrice'],
       presentPrice : json['presentPrice'],
       goodsName : json['goodsName'],
       goodsId : json['goodsId'],
     );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['goodsName'] = this.goodsName;
    data['goodsId'] = this.goodsId;
    return data;
  }
}