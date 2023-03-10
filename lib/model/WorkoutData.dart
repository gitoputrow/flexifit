class WorkoutData {
  List<Data>? _data;
  String? _picture;
  int? _reps;
  String? _title;

  WorkoutData({List<Data>? data, String? picture, int? reps, String? title}) {
    if (data != null) {
      this._data = data;
    }
    if (picture != null) {
      this._picture = picture;
    }
    if (reps != null) {
      this._reps = reps;
    }
    if (title != null) {
      this._title = title;
    }
  }

  List<Data>? get data => _data;
  set data(List<Data>? data) => _data = data;
  String? get picture => _picture;
  set picture(String? picture) => _picture = picture;
  int? get reps => _reps;
  set reps(int? reps) => _reps = reps;
  String? get title => _title;
  set title(String? title) => _title = title;

  WorkoutData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(new Data.fromJson(v));
      });
    }
    _picture = json['picture'];
    _reps = json['reps'];
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    data['picture'] = this._picture;
    data['reps'] = this._reps;
    data['title'] = this._title;
    return data;
  }
}

class Data {
  String? _title;
  String? _picture;
  String? _previewPicture;

  Data({String? title, String? picture, String? previewPicture}) {
    if (title != null) {
      this._title = title;
    }
    if (picture != null) {
      this._picture = picture;
    }
    if (previewPicture != null) {
      this._previewPicture = previewPicture;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  String? get picture => _picture;
  set picture(String? picture) => _picture = picture;
  String? get previewPicture => _previewPicture;
  set previewPicture(String? previewPicture) =>
      _previewPicture = previewPicture;

  Data.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _picture = json['picture'];
    _previewPicture = json['previewPicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this._title;
    data['picture'] = this._picture;
    data['previewPicture'] = this._previewPicture;
    return data;
  }
}
