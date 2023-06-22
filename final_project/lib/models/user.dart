class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String password;

  User({
    this.id = 0,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  factory User.fromJson(json) {
    return User(
      id: json["id"] ?? 0,
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
    };
  }
}
