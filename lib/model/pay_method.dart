class PayMethodMode {
  int pay_id;
  String pay_name;
  // int member_id;
  // String pay_id;

  PayMethodMode(
      {
        this.pay_id,
        this.pay_name,
      });

  PayMethodMode.fromJson(Map<String, dynamic> json) {
    pay_id = json['pay_id'];
    pay_name = json['pay_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pay_name'] = this.pay_name;
    data['pay_id'] = this.pay_id;
    return data;
  }
}