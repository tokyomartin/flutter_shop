class ProvinceMode {
  int   ? id;
  String? pref_name;
  // int member_id;
  // String pay_id;

  ProvinceMode(
      {
        this.id,
        this.pref_name,
      });

  ProvinceMode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pref_name = json['pref_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pref_name'] = this.pref_name;
    data['id'] = this.id;
    return data;
  }
}