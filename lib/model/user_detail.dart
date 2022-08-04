class UserDetailMode {
  String? id;
  String? displayName;
  String? email;
  String? photoUrl;
  String? serverAuthCode;

  UserDetailMode(
      {
        this.id,
        this.displayName,
        this.email,
        this.photoUrl,
        this.serverAuthCode
      });

  factory UserDetailMode.fromJson(Map<String, dynamic> json) {
    return  UserDetailMode(
      id : json['id'],
    displayName : json['displayName'] ,
    email : json['email'],
    photoUrl : json['photoURL'],
    serverAuthCode : json['serverAuthCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['photoURL'] = this.photoUrl;
    data['serverAuthCode'] = this.serverAuthCode;

    return data;
  }
}