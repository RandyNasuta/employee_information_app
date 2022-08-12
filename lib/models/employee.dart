class Employee {
  String _name;
  String _avatar;
  String _position;
  String _id;

  String get name => this._name;
  set name(String value) => this._name = value;

  String get avatar => this._avatar;
  set avatar(value) => this._avatar = value;

  String get position => this._position;
  set position(value) => this._position = value;

  String get id => this._id;
  set id(value) => this._id = value;

  Employee({name, avatar, position, id})
      : this._name = name,
        this._avatar = avatar,
        this._position = position,
        this._id = id;

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      avatar: json['avatar'],
      position: json['position'],
      id: json['id'],
    );
  }
}
