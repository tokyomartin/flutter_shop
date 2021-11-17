class UserModel {
  String id;
  // String displayName;
  String email;
  String password;
  String password_confirmation;



  UserModel(
      {this.id, this.email, this.password , this.password_confirmation });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ;
    // displayName = json['displayName'];
    email = json['email'];
    password = json['password'];
    password_confirmation = json['password_confirmation'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    // data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.password_confirmation;

    return data;
  }
}