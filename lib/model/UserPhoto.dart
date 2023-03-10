class UserPhoto {
  String? _date;
  String? _days;
  String? _id;
  String? _url;

  UserPhoto({String? date, String? days, String? id, String? url}) {
    if (date != null) {
      this._date = date;
    }
    if (days != null) {
      this._days = days;
    }
    if (id != null) {
      this._id = id;
    }
    if (url != null) {
      this._url = url;
    }
  }

  String? get date => _date;
  set date(String? date) => _date = date;
  String? get days => _days;
  set days(String? days) => _days = days;
  String? get id => _id;
  set id(String? id) => _id = id;
  String? get url => _url;
  set url(String? url) => _url = url;

  UserPhoto.fromJson(Map<String, dynamic> json) {
    _date = json['date'];
    _days = json['days'];
    _id = json['id'];
    _url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this._date;
    data['days'] = this._days;
    data['id'] = this._id;
    data['url'] = this._url;
    return data;
  }
}
