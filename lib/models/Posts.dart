class PostsModel {
  String userName;
  String uid;
  String date;
  String image;
  String text;
  String imagepost;
  PostsModel(
      {this.userName,
      this.date,
      this.uid,
      this.image,
      this.imagepost,
      this.text});

  PostsModel.fromJson(Map<String, dynamic> json) {
    userName = json['name'];
    date = json['date'];
    imagepost = json['imagepost'];
    uid = json['uid'];
    image = json['image'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': userName,
      'uid': uid,
      'date': date,
      'image': image,
      'text': text,
      'imagepost': imagepost,
    };
  }
}
