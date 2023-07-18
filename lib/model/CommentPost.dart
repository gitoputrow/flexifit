class CommentPost {
  String? _comment;
  String? _date;
  String? _id;
  String? _profilePic;
  String? _username;

  CommentPost(
      {String? comment,
      String? date,
      String? id,
      String? profilePic,
      String? username}) {
    if (comment != null) {
      this._comment = comment;
    }
    if (date != null) {
      this._date = date;
    }
    if (id != null) {
      this._id = id;
    }
    if (profilePic != null) {
      this._profilePic = profilePic;
    }
    if (username != null) {
      this._username = username;
    }
  }

  String? get comment => _comment;
  set comment(String? comment) => _comment = comment;
  String? get date => _date;
  set date(String? date) => _date = date;
  String? get id => _id;
  set id(String? id) => _id = id;
  String? get profilePic => _profilePic;
  set profilePic(String? profilePic) => _profilePic = profilePic;
  String? get username => _username;
  set username(String? username) => _username = username;

  CommentPost.fromJson(Map<String, dynamic> json) {
    _comment = json['comment'];
    _date = json['date'];
    _id = json['id'];
    _profilePic = json['profilePic'];
    _username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this._comment;
    data['date'] = this._date;
    data['id'] = this._id;
    data['profilePic'] = this._profilePic;
    data['username'] = this._username;
    return data;
  }
}
