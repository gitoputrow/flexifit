class Challange {
  List<Level>? _level;
  String? _picture;
  String? _title;

  Challange({List<Level>? level, String? picture, String? title}) {
    if (level != null) {
      this._level = level;
    }
    if (picture != null) {
      this._picture = picture;
    }
    if (title != null) {
      this._title = title;
    }
  }

  List<Level>? get level => _level;
  set level(List<Level>? level) => _level = level;
  String? get picture => _picture;
  set picture(String? picture) => _picture = picture;
  String? get title => _title;
  set title(String? title) => _title = title;

  Challange.fromJson(Map<String, dynamic> json) {
    if (json['Level'] != null) {
      _level = <Level>[];
      json['Level'].forEach((v) {
        _level!.add(new Level.fromJson(v));
      });
    }
    _picture = json['picture'];
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._level != null) {
      data['Level'] = this._level!.map((v) => v.toJson()).toList();
    }
    data['picture'] = this._picture;
    data['title'] = this._title;
    return data;
  }
}

class Level {
  String? _desc;
  String? _picture;
  String? _title;
  String? _total;

  Level({String? desc, String? picture, String? title, String? total}) {
    if (desc != null) {
      this._desc = desc;
    }
    if (picture != null) {
      this._picture = picture;
    }
    if (title != null) {
      this._title = title;
    }
    if (total != null) {
      this._total = total;
    }
  }

  String? get desc => _desc;
  set desc(String? desc) => _desc = desc;
  String? get picture => _picture;
  set picture(String? picture) => _picture = picture;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get total => _total;
  set total(String? total) => _total = total;

  Level.fromJson(Map<String, dynamic> json) {
    _desc = json['desc'];
    _picture = json['picture'];
    _title = json['title'];
    _total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this._desc;
    data['picture'] = this._picture;
    data['title'] = this._title;
    data['total'] = this._total;
    return data;
  }
}
