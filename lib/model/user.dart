class UserModel {
  String? id;
  // String displayName;
  String? email;
  String? password;
  String? password_confirmation;



  UserModel(
      {
        this.id,
        this.email,
        this.password ,
        this.password_confirmation
      });

  factory UserModel.fromJson(Map<String, dynamic> json) {
     return  UserModel(
       id: json['id'],
       password :json['password'],
       password_confirmation : json['password_confirmation'],
     );
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