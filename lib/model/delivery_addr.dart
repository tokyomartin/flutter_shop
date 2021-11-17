class DeliveryAddrMode {
  int id;
  int member_id;
  String post_code_front;
  String post_code_back;
  String prefecture;
  String city;
  String address1;
  String last_name;
  String first_name;
  String last_name_kana;
  String first_name_kana;
  String company_name;
  String phone_number;
  int is_default;

  DeliveryAddrMode(
      {this.id,
        this.member_id,
        this.post_code_front,
        this.post_code_back,
        this.prefecture,
        this.city,
        this.address1,
        this.last_name,
        this.first_name,
        this.last_name_kana,
        this.first_name_kana,
        this.company_name,
        this.phone_number,
        this.is_default,
      });

  DeliveryAddrMode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    member_id = json['member_id'];
    post_code_front = json['post_code_front'];
    post_code_back = json['post_code_back'];
    prefecture = json['prefecture'];
    city = json['city'];
    address1 = json['address1'];
    last_name = json['last_name'];
    first_name = json['first_name'];
    last_name_kana = json['last_name_kana'];
    first_name_kana = json['first_name_kana'];
    company_name = json['company_name'];
    phone_number = json['phone_number'];
    is_default = json['is_default'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['member_id'] = this.member_id;
    data['post_code_front'] = this.post_code_front;
    data['post_code_back'] = this.post_code_back;
    data['prefecture'] = this.prefecture;
    data['city'] = this.city;
    data['address1']= this.address1;
    data['last_name'] = this.last_name;
    data['first_name']= this.first_name;
    data['last_name_kana'] = this.last_name_kana;
    data['first_name_kana']= this.first_name_kana;
    data['company_name']= this.company_name;
    data['phone_number']= this.phone_number;
    data['is_default']= this.is_default;

    return data;
  }
}