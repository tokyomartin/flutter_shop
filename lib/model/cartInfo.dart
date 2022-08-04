class CartInfoMode {
    int      product_id;
    String   product_name;
    int      quantity;
    int      price;
    String?  small_pic;
    bool  ?  checked;

  CartInfoMode({
     required this.product_id,
     required this.product_name,
     required this.quantity,
     required this.price,
     this.small_pic,
     this.checked
  });

  factory CartInfoMode.fromJson(Map<String, dynamic> json) {
     dynamic product_id = int.parse(json['product_id'].toString());
     dynamic product_name = json['product_name'];
     dynamic quantity = int.parse(json['quantity'].toString());
     dynamic price = int.parse(json['price'].toString());
     dynamic small_pic = json['small_pic'];
     dynamic checked = json['checked'];

    return  CartInfoMode(
      product_id : product_id,
      product_name : product_name,
      quantity : quantity,
      price : price,
      small_pic : small_pic,
      checked : checked,
    );
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