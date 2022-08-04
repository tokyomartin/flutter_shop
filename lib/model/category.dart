
import 'SubCategory.dart';

class Category {
  final int cate_id;
  final String parent_id;
  final String shop_id;
  final String cate_name;
  final String cate_field_name;
  //final List<SubCategory> sub_category_list;
  // String image;

  Category(
      {
        required this.cate_id,
        required this.parent_id,
        required this.shop_id,
        required this.cate_name,
        required this.cate_field_name,
// required this.sub_category_list,
      // this.comments,
      // this.image
      });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      cate_id : json['cate_id'],
      parent_id : json['parent_id'],
      shop_id : json['shop_id'],
      cate_name : json['cate_name'],
      cate_field_name : json['cate_field_name'],
    ) ;
    // cate_id = json['cate_id'];
    // cate_name = json['cate_name'];
    // if (json['bxMallSubDto'] != null) {
    //   sub_category_list = new List<sub_category_list>();
    //   json['sub_category_list'].forEach((v) {
    //     sub_category_list.add(new sub_category_list.fromJson(v));
    //   });
    // }
    // comments = json['comments'];
    // image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cate_id'] = this.cate_id;
    data['parent_id'] = this.parent_id;
    data['shop_id'] = this.shop_id;
    data['cate_name'] = this.cate_name;
    data['cate_field_name'] = this.cate_field_name;

    // if (this.sub_category_list != null) {
    //   data['sub_category_list'] = this.sub_category_list.map((v) => v.toJson()).toList();
    // }
    // data['comments'] = this.comments;
    // data['image'] = this.image;

    return data;
  }
}
