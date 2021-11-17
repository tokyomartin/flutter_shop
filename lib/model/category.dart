class CategoryModel {
  String code;
  String message;
  List<Category> data;

  CategoryModel({this.code, this.message, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Category>();
      json['data'].forEach((v) {
        data.add(new Category.fromJson(v));
      });
    }
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

class Category {
  int cate_id;
  String parent_id;
  String shop_id;
  String cate_name;
  String cate_field_name;
  List<BxMallSubDto> bxMallSubDto;
  // String image;

  Category(
      {this.cate_id,
      this.parent_id,
        this.shop_id,
        this.cate_name,
        this.cate_field_name,
      this.bxMallSubDto,
      // this.comments,
      // this.image
      });

  Category.fromJson(Map<String, dynamic> json) {
    cate_id = json['cate_id'];
    cate_name = json['cate_name'];
    if (json['bxMallSubDto'] != null) {
      bxMallSubDto = new List<BxMallSubDto>();
      json['bxMallSubDto'].forEach((v) {
        bxMallSubDto.add(new BxMallSubDto.fromJson(v));
      });
    }
    // comments = json['comments'];
    // image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cate_id'] = this.cate_id;
    data['cate_name'] = this.cate_name;
    if (this.bxMallSubDto != null) {
      data['bxMallSubDto'] = this.bxMallSubDto.map((v) => v.toJson()).toList();
    }
    // data['comments'] = this.comments;
    // data['image'] = this.image;

    return data;
  }
}

class BxMallSubDto {
  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  String comments;

  BxMallSubDto(
      {this.mallSubId, this.mallCategoryId, this.mallSubName, this.comments});

  BxMallSubDto.fromJson(Map<String, dynamic> json) {
    mallSubId = json['mallSubId'];
    mallCategoryId = json['mallCategoryId'];
    mallSubName = json['mallSubName'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallSubId'] = this.mallSubId;
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallSubName'] = this.mallSubName;
    data['comments'] = this.comments;
    return data;
  }
}