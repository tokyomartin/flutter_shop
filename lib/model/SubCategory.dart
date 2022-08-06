
class SubCategory {
  String sub_category_id;
  String category_id;
  String sub_category_name;
  String? comments;

  SubCategory(
      {
        required this.sub_category_id,
        required this.category_id,
        required this.sub_category_name,
        this.comments,
      });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      sub_category_id : json['sub_category_id'],
      category_id : json['category_id'],
      sub_category_name : json['sub_category_name'],
      comments : json['comments'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_category_id'] = this.sub_category_id;
    data['category_id'] = this.category_id;
    data['sub_category_name'] = this.sub_category_name;
    data['comments'] = this.comments;

    return data;
  }
}