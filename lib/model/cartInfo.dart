class CartInfoMode {
  int product_id;
  String product_name;
  int quantity;
  int price;
  String small_pic;
  bool checked;

  CartInfoMode(
      {this.product_id, this.product_name, this.quantity, this.price, this.small_pic,this.checked});

  CartInfoMode.fromJson(Map<String, dynamic> json) {
    product_id = int.parse(json['product_id'].toString());
    product_name = json['product_name'];
    quantity = int.parse(json['quantity'].toString());
    price = int.parse(json['price'].toString());
    small_pic = json['small_pic'];
    checked = json['checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.product_id;
    data['product_name'] = this.product_name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['small_pic'] = this.small_pic;
    data['checked']= this.checked;
    return data;
  }
}