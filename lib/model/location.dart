class LocationMode {
  int id;
  String company_name;
  String company_phone_number;
  String post_code_front;
  String post_code_back;
  String city;
  String address1;



  // int member_id;
  // String pay_id;

  LocationMode(
      {
        this.id,
        this.company_name,
        this.company_phone_number,
        this.post_code_front,
        this.post_code_back,
        this.city,
        this.address1,
      });

  LocationMode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company_name = json['company_name'];
    company_phone_number = json['company_phone_number'];
    post_code_front = json['post_code_front'];
    post_code_back = json['post_code_back'];
    city = json['city'];
    address1 = json['address1'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.company_name;
    data['company_phone_number'] = this.company_phone_number;
    data['post_code_front'] = this.post_code_front;
    data['post_code_back'] = this.post_code_back;
    data['city'] = this.city;
    data['address1'] = this.address1;
    data['id'] = this.id;
    return data;
  }
}