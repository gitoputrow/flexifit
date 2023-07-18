class UserPost {
  String? _caption;
  int? _comment;
  String? _date;
  int? _dislike;
  String? _id;
  String? _imageSource;
  int? _like;
  String? _profilepicture;
  String? _username;
  bool liked = false;

  UserPost(
      {String? caption,
      int? comment,
      String? date,
      int? dislike,
      String? id,
      String? imageSource,
      int? like,
      String? profilepicture,
      String? username}) {
    if (caption != null) {
      this._caption = caption;
    }
    if (comment != null) {
      this._comment = comment;
    }
    if (date != null) {
      this._date = date;
    }
    if (dislike != null) {
      this._dislike = dislike;
    }
    if (id != null) {
      this._id = id;
    }
    if (imageSource != null) {
      this._imageSource = imageSource;
    }
    if (like != null) {
      this._like = like;
    }
    if (profilepicture != null) {
      this._profilepicture = profilepicture;
    }
    if (username != null) {
      this._username = username;
    }
  }

  String? get caption => _caption;
  set caption(String? caption) => _caption = caption;
  int? get comment => _comment;
  set comment(int? comment) => _comment = comment;
  String? get date => _date;
  set date(String? date) => _date = date;
  int? get dislike => _dislike;
  set dislike(int? dislike) => _dislike = dislike;
  String? get id => _id;
  set id(String? id) => _id = id;
  String? get imageSource => _imageSource;
  set imageSource(String? imageSource) => _imageSource = imageSource;
  int? get like => _like;
  set like(int? like) => _like = like;
  String? get profilepicture => _profilepicture;
  set profilepicture(String? profilepicture) => _profilepicture = profilepicture;
  String? get username => _username;
  set username(String? username) => _username = username;

  UserPost.fromJson(Map<String, dynamic> json) {
    _caption = json['caption'];
    _comment = json['comment'];
    _date = json['date'];
    _dislike = json['dislike'];
    _id = json['id'];
    _imageSource = json['imageSource'];
    _like = json['like'];
    _profilepicture = json['profilepicture'];
    _username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caption'] = this._caption;
    data['comment'] = this._comment;
    data['date'] = this._date;
    data['dislike'] = this._dislike;
    data['id'] = this._id;
    data['imageSource'] = this._imageSource;
    data['like'] = this._like;
    data['profilepicture'] = this._profilepicture;
    data['username'] = this._username;
    return data;
  }
}
