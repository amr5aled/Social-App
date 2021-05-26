class RegisterModel {
  String userName;
  String email;
  String phone;
  String uid;
  bool isemailverified;
  String cover;
  String image;
  String bio;
  RegisterModel(
      {this.userName,
      this.email,
      this.phone,
      this.uid,
      this.isemailverified,
      this.image,
      this.bio,
      this.cover});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    userName = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['Uid'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    isemailverified = json['isemailveified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': userName,
      'email': email,
      'phone': phone,
      'Uid': uid,
      'image': image,
      'bio': bio,
      'cover': cover,
      'isemailveified': isemailverified
    };
  }
}
