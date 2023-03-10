class ProgramWO {
  String? _day;
  String? _picture;
  String? _dayDesc;
  String? _title;
  String? _workoutName;

  ProgramWO(
      {String? day,
      String? picture,
      String? dayDesc,
      String? title,
      String? workoutName}) {
    if (day != null) {
      this._day = day;
    }
    if (picture != null) {
      this._picture = picture;
    }
    if (dayDesc != null) {
      this._dayDesc = dayDesc;
    }
    if (title != null) {
      this._title = title;
    }
    if (workoutName != null) {
      this._workoutName = workoutName;
    }
  }

  String? get day => _day;
  set day(String? day) => _day = day;
  String? get picture => _picture;
  set picture(String? picture) => _picture = picture;
  String? get dayDesc => _dayDesc;
  set dayDesc(String? dayDesc) => _dayDesc = dayDesc;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get workoutName => _workoutName;
  set workoutName(String? workoutName) => _workoutName = workoutName;

  ProgramWO.fromJson(Map<String, dynamic> json) {
    _day = json['day'];
    _picture = json['picture'];
    _dayDesc = json['dayDesc'];
    _title = json['title'];
    _workoutName = json['workoutName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this._day;
    data['picture'] = this._picture;
    data['dayDesc'] = this._dayDesc;
    data['title'] = this._title;
    data['workoutName'] = this._workoutName;
    return data;
  }
}
