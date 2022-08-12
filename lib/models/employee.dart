class Employee {
  String _name;
  String _avatar;
  String _position;
  String _id;

  String get name => _name;
  set name(String value) => _name = value;

  String get avatar => _avatar;
  set avatar(value) => _avatar = value;

  String get position => _position;
  set position(value) => _position = value;

  String get id => _id;
  set id(value) => _id = value;

  Employee({name, avatar, position, id})
      : _name = name,
        _avatar = avatar,
        _position = position,
        _id = id;

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      avatar: json['avatar'],
      position: json['position'],
      id: json['id'],
    );
  }
}
