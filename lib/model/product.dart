

class Product{

  final int id;
  final int distributor_id;
  final String product_name;
  final int general_price;
  final int current_price;
  final String small_img_url;
  final String image_url_1;
  final String image_url_2;
  final String image_url_3;
  final String image_url_4;
  final String image_url_5;
  final String product_code;
  final String jan_code;
  final int sub_category_id;
  final int product_total_amount;
  final int product_sold_total_amount;
  final String discription;


    Product(
    {
      required this.id,
      required this.distributor_id,
      required this.product_name,
      required this.general_price,
      required this.current_price,
      required this.small_img_url,
      required this.image_url_1,
      required this.image_url_2,
      required this.image_url_3,
      required this.image_url_4,
      required this.image_url_5,
      required this.product_code,
      required this.jan_code,
      required this.sub_category_id,
      required this.product_total_amount,
      required this.product_sold_total_amount,
      required this.discription,
    });

factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id : json['id'],
    distributor_id : int.parse(json['distributor_id']),
    product_name : json['product_name'],
    general_price : json['general_price'],
    current_price : json['current_price'],
    small_img_url : json['small_img_url'],
    image_url_1 : json['image_url_1'],
    image_url_2 : json['image_url_2'],
    image_url_3 : json['image_url_3'],
    image_url_4 : json['image_url_4'],
    image_url_5 : json['image_url_5'],
    product_code : json['product_code'],
    jan_code : json['jan_code'],
    sub_category_id : json['sub_category_id'],
    product_total_amount : json['product_total_amount'],
    product_sold_total_amount : json['product_sold_total_amount'],
    discription : json['discription'],
  );
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