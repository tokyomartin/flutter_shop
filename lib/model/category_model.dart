import 'category.dart';

class CategoryModel {

   final String code;
   final String message;
   final List<Category> data;

  CategoryModel({
    required this.code,
    required this.message,
    required List<Category> data,
  }): data = data ;//?? <Category>[];

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    dynamic code = json['code'];
    dynamic message = json['message'];
    dynamic data = <Category>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new Category.fromJson(v));
      });
    }
    return CategoryModel(code: code, message: message, data: data);
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
