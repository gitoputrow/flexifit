class UserData {
  String? _age;
  ChallengeData? _challengeData;
  int? _dislike;
  String? _gender;
  String? _goal;
  String? _height;
  int? _like;
  String? _name;
  String? _pass;
  String? _photoprofile;
  String? _physical;
  int? _post;
  List<TargetMuscle>? _targetMuscle;
  String? _username;
  String? _weight;

  UserData(
      {String? age,
      ChallengeData? challengeData,
      int? dislike,
      String? gender,
      String? goal,
      String? height,
      int? like,
      String? name,
      String? pass,
      String? photoprofile,
      String? physical,
      int? post,
      List<TargetMuscle>? targetMuscle,
      String? username,
      String? weight}) {
    if (age != null) {
      this._age = age;
    }
    if (challengeData != null) {
      this._challengeData = challengeData;
    }
    if (dislike != null) {
      this._dislike = dislike;
    }
    if (gender != null) {
      this._gender = gender;
    }
    if (goal != null) {
      this._goal = goal;
    }
    if (height != null) {
      this._height = height;
    }
    if (like != null) {
      this._like = like;
    }
    if (name != null) {
      this._name = name;
    }
    if (pass != null) {
      this._pass = pass;
    }
    if (photoprofile != null) {
      this._photoprofile = photoprofile;
    }
    if (physical != null) {
      this._physical = physical;
    }
    if (post != null) {
      this._post = post;
    }
    if (targetMuscle != null) {
      this._targetMuscle = targetMuscle;
    }
    if (username != null) {
      this._username = username;
    }
    if (weight != null) {
      this._weight = weight;
    }
  }

  String? get age => _age;
  set age(String? age) => _age = age;
  ChallengeData? get challengeData => _challengeData;
  set challengeData(ChallengeData? challengeData) =>
      _challengeData = challengeData;
  int? get dislike => _dislike;
  set dislike(int? dislike) => _dislike = dislike;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  String? get goal => _goal;
  set goal(String? goal) => _goal = goal;
  String? get height => _height;
  set height(String? height) => _height = height;
  int? get like => _like;
  set like(int? like) => _like = like;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get pass => _pass;
  set pass(String? pass) => _pass = pass;
  String? get photoprofile => _photoprofile;
  set photoprofile(String? photoprofile) => _photoprofile = photoprofile;
  String? get physical => _physical;
  set physical(String? physical) => _physical = physical;
  int? get post => _post;
  set post(int? post) => _post = post;
  List<TargetMuscle>? get targetMuscle => _targetMuscle;
  set targetMuscle(List<TargetMuscle>? targetMuscle) =>
      _targetMuscle = targetMuscle;
  String? get username => _username;
  set username(String? username) => _username = username;
  String? get weight => _weight;
  set weight(String? weight) => _weight = weight;

  UserData.fromJson(Map<String, dynamic> json) {
    _age = json['age'];
    _challengeData = json['challenge_data'] != null
        ? new ChallengeData.fromJson(json['challenge_data'])
        : null;
    _dislike = json['dislike'];
    _gender = json['gender'];
    _goal = json['goal'];
    _height = json['height'];
    _like = json['like'];
    _name = json['name'];
    _pass = json['pass'];
    _photoprofile = json['photo_profile'];
    _physical = json['physical'];
    _post = json['post'];
    if (json['target_muscle'] != null) {
      _targetMuscle = <TargetMuscle>[];
      json['target_muscle'].forEach((v) {
        _targetMuscle!.add(new TargetMuscle.fromJson(v));
      });
    }
    _username = json['username'];
    _weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this._age;
    if (this._challengeData != null) {
      data['challengeData'] = this._challengeData!.toJson();
    }
    data['dislike'] = this._dislike;
    data['gender'] = this._gender;
    data['goal'] = this._goal;
    data['height'] = this._height;
    data['like'] = this._like;
    data['name'] = this._name;
    data['pass'] = this._pass;
    data['photoprofile'] = this._photoprofile;
    data['physical'] = this._physical;
    data['post'] = this._post;
    if (this._targetMuscle != null) {
      data['targetMuscle'] =
          this._targetMuscle!.map((v) => v.toJson()).toList();
    }
    data['username'] = this._username;
    data['weight'] = this._weight;
    return data;
  }
}

class ChallengeData {
  int? _absBeginner;
  int? _absIntermediate;
  int? _bicepsBeginner;
  int? _bicepsIntermediate;
  int? _cardioBeginner;
  int? _cardioIntermediate;
  int? _chestBeginner;
  int? _chestIntermediate;
  int? _fullBodyBeginner;
  int? _fullBodyIntermediate;
  int? _legsBeginner;
  int? _legsIntermediate;
  int? _tricepsBeginner;
  int? _tricepsIntermediate;

  ChallengeData(
      {int? absBeginner,
      int? absIntermediate,
      int? bicepsBeginner,
      int? bicepsIntermediate,
      int? cardioBeginner,
      int? cardioIntermediate,
      int? chestBeginner,
      int? chestIntermediate,
      int? fullBodyBeginner,
      int? fullBodyIntermediate,
      int? legsBeginner,
      int? legsIntermediate,
      int? tricepsBeginner,
      int? tricepsIntermediate}) {
    if (absBeginner != null) {
      this._absBeginner = absBeginner;
    }
    if (absIntermediate != null) {
      this._absIntermediate = absIntermediate;
    }
    if (bicepsBeginner != null) {
      this._bicepsBeginner = bicepsBeginner;
    }
    if (bicepsIntermediate != null) {
      this._bicepsIntermediate = bicepsIntermediate;
    }
    if (cardioBeginner != null) {
      this._cardioBeginner = cardioBeginner;
    }
    if (cardioIntermediate != null) {
      this._cardioIntermediate = cardioIntermediate;
    }
    if (chestBeginner != null) {
      this._chestBeginner = chestBeginner;
    }
    if (chestIntermediate != null) {
      this._chestIntermediate = chestIntermediate;
    }
    if (fullBodyBeginner != null) {
      this._fullBodyBeginner = fullBodyBeginner;
    }
    if (fullBodyIntermediate != null) {
      this._fullBodyIntermediate = fullBodyIntermediate;
    }
    if (legsBeginner != null) {
      this._legsBeginner = legsBeginner;
    }
    if (legsIntermediate != null) {
      this._legsIntermediate = legsIntermediate;
    }
    if (tricepsBeginner != null) {
      this._tricepsBeginner = tricepsBeginner;
    }
    if (tricepsIntermediate != null) {
      this._tricepsIntermediate = tricepsIntermediate;
    }
  }

  int? get absBeginner => _absBeginner;
  set absBeginner(int? absBeginner) => _absBeginner = absBeginner;
  int? get absIntermediate => _absIntermediate;
  set absIntermediate(int? absIntermediate) =>
      _absIntermediate = absIntermediate;
  int? get bicepsBeginner => _bicepsBeginner;
  set bicepsBeginner(int? bicepsBeginner) => _bicepsBeginner = bicepsBeginner;
  int? get bicepsIntermediate => _bicepsIntermediate;
  set bicepsIntermediate(int? bicepsIntermediate) =>
      _bicepsIntermediate = bicepsIntermediate;
  int? get cardioBeginner => _cardioBeginner;
  set cardioBeginner(int? cardioBeginner) => _cardioBeginner = cardioBeginner;
  int? get cardioIntermediate => _cardioIntermediate;
  set cardioIntermediate(int? cardioIntermediate) =>
      _cardioIntermediate = cardioIntermediate;
  int? get chestBeginner => _chestBeginner;
  set chestBeginner(int? chestBeginner) => _chestBeginner = chestBeginner;
  int? get chestIntermediate => _chestIntermediate;
  set chestIntermediate(int? chestIntermediate) =>
      _chestIntermediate = chestIntermediate;
  int? get fullBodyBeginner => _fullBodyBeginner;
  set fullBodyBeginner(int? fullBodyBeginner) =>
      _fullBodyBeginner = fullBodyBeginner;
  int? get fullBodyIntermediate => _fullBodyIntermediate;
  set fullBodyIntermediate(int? fullBodyIntermediate) =>
      _fullBodyIntermediate = fullBodyIntermediate;
  int? get legsBeginner => _legsBeginner;
  set legsBeginner(int? legsBeginner) => _legsBeginner = legsBeginner;
  int? get legsIntermediate => _legsIntermediate;
  set legsIntermediate(int? legsIntermediate) =>
      _legsIntermediate = legsIntermediate;
  int? get tricepsBeginner => _tricepsBeginner;
  set tricepsBeginner(int? tricepsBeginner) =>
      _tricepsBeginner = tricepsBeginner;
  int? get tricepsIntermediate => _tricepsIntermediate;
  set tricepsIntermediate(int? tricepsIntermediate) =>
      _tricepsIntermediate = tricepsIntermediate;

  ChallengeData.fromJson(Map<String, dynamic> json) {
    _absBeginner = json['AbsBeginner'];
    _absIntermediate = json['AbsIntermediate'];
    _bicepsBeginner = json['BicepsBeginner'];
    _bicepsIntermediate = json['BicepsIntermediate'];
    _cardioBeginner = json['CardioBeginner'];
    _cardioIntermediate = json['CardioIntermediate'];
    _chestBeginner = json['ChestBeginner'];
    _chestIntermediate = json['ChestIntermediate'];
    _fullBodyBeginner = json['Full BodyBeginner'];
    _fullBodyIntermediate = json['Full BodyIntermediate'];
    _legsBeginner = json['LegsBeginner'];
    _legsIntermediate = json['LegsIntermediate'];
    _tricepsBeginner = json['TricepsBeginner'];
    _tricepsIntermediate = json['TricepsIntermediate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AbsBeginner'] = this._absBeginner;
    data['AbsIntermediate'] = this._absIntermediate;
    data['BicepsBeginner'] = this._bicepsBeginner;
    data['BicepsIntermediate'] = this._bicepsIntermediate;
    data['CardioBeginner'] = this._cardioBeginner;
    data['CardioIntermediate'] = this._cardioIntermediate;
    data['ChestBeginner'] = this._chestBeginner;
    data['ChestIntermediate'] = this._chestIntermediate;
    data['Full BodyBeginner'] = this._fullBodyBeginner;
    data['Full BodyIntermediate'] = this._fullBodyIntermediate;
    data['LegsBeginner'] = this._legsBeginner;
    data['LegsIntermediate'] = this._legsIntermediate;
    data['TricepsBeginner'] = this._tricepsBeginner;
    data['TricepsIntermediate'] = this._tricepsIntermediate;
    return data;
  }
}

class TargetMuscle {
  String? _muscle;

  TargetMuscle({String? muscle}) {
    if (muscle != null) {
      this._muscle = muscle;
    }
  }

  String? get muscle => _muscle;
  set muscle(String? muscle) => _muscle = muscle;

  TargetMuscle.fromJson(Map<String, dynamic> json) {
    _muscle = json['muscle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['muscle'] = this._muscle;
    return data;
  }
}
