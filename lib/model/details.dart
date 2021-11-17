class DetailsModel {
  String code;
  String message;
  DetailsGoodsData data;

  DetailsModel({this.code, this.message, this.data});

  DetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new DetailsGoodsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DetailsGoodsData {
  Product product;
  List<GoodComments> goodComments;
  AdvertesPicture advertesPicture;

  DetailsGoodsData({this.product, this.goodComments, this.advertesPicture});

  DetailsGoodsData.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null
        ? new Product.fromJson(json['product'])
        : null;
    if (json['goodComments'] != null) {
      goodComments = new List<GoodComments>();
      json['goodComments'].forEach((v) {
        goodComments.add(new GoodComments.fromJson(v));
      });
    }
    advertesPicture = json['advertesPicture'] != null
        ? new AdvertesPicture.fromJson(json['advertesPicture'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.goodComments != null) {
      data['goodComments'] = this.goodComments.map((v) => v.toJson()).toList();
    }
    if (this.advertesPicture != null) {
      data['advertesPicture'] = this.advertesPicture.toJson();
    }
    return data;
  }
}

class Product {

  int id;
  String distributor_id;
  String product_name;
  int general_price;
  int current_price;
  String small_img_url;
  String image_url_1;
  String image_url_2;
  String image_url_3;
  String image_url_4;
  String image_url_5;
  String product_code;
  String jan_code;

  int sub_category_id;
  int product_total_amount;
  int product_sold_total_amount;

  String discription;


  // String image5;
  // int amount;
  // String image3;
  // String image4;
  // String goodsId;
  // String isOnline;
  // String image1;
  // String image2;
  // String goodsSerialNumber;
  // double oriPrice;
  // double presentPrice;
  // String comPic;
  // int state;
  // String shopId;
  // String goodsName;
  // String goodsDetail;

  Product(
      {
        this.id,
        this.distributor_id,
        this.product_name,
        this.general_price,
        this.current_price,
        this.small_img_url,
        this.image_url_1,
        this.image_url_2,
        this.image_url_3,
        this.image_url_4,
        this.image_url_5,
        this.product_code,
        this.jan_code,

        this.sub_category_id,
        this.product_total_amount,
        this.product_sold_total_amount,
        this.discription
      });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    distributor_id = json['distributor_id'];
    product_name = json['product_name'];
    general_price = json['general_price'];
    current_price = json['current_price'];
    small_img_url = json['small_img_url'];
    image_url_1 = json['image_url_1'];
    image_url_2 = json['image_url_2'];
    image_url_3 = json['image_url_3'];
    image_url_4 = json['image_url_4'];
    image_url_5 = json['image_url_5'];
    product_code = json['product_code'];
    jan_code = json['jan_code'];
    sub_category_id = json['sub_category_id'];
    product_total_amount = json['product_total_amount'];
    product_sold_total_amount = json['product_sold_total_amount'];
    discription = json['discription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['distributor_id'] = this.distributor_id;
    data['product_name'] = this.product_name;
    data['general_price'] = this.general_price;
    data['current_price'] = this.current_price;
    data['small_img_url'] = this.small_img_url;
    data['image_url_1'] = this.image_url_1;
    data['image_url_2'] = this.image_url_2;
    data['image_url_3'] = this.image_url_3;
    data['image_url_4'] = this.image_url_4;
    data['image_url_5'] = this.image_url_5;
    data['product_code'] = this.product_code;
    data['jan_code'] = this.jan_code;
    data['sub_category_id'] = this.sub_category_id;
    data['product_total_amount'] = this.product_total_amount;
    data['product_sold_total_amount'] = this.product_sold_total_amount;
    data['discription'] = this.discription;
    return data;
  }
}

class GoodComments {
  int sCORE;
  String comments;
  String userName;
  int discussTime;

  GoodComments({this.sCORE, this.comments, this.userName, this.discussTime});

  GoodComments.fromJson(Map<String, dynamic> json) {
    sCORE = json['SCORE'];
    comments = json['comments'];
    userName = json['userName'];
    discussTime = json['discussTime'];
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
  String pICTUREADDRESS;
  String tOPLACE;

  AdvertesPicture({this.pICTUREADDRESS, this.tOPLACE});

  AdvertesPicture.fromJson(Map<String, dynamic> json) {
    pICTUREADDRESS = json['PICTURE_ADDRESS'];
    tOPLACE = json['TO_PLACE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.pICTUREADDRESS;
    data['TO_PLACE'] = this.tOPLACE;
    return data;
  }
}
