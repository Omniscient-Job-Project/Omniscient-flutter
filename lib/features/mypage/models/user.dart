class User {
  final String userName;

  User({required this.userName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['username'],
    );
  }
}
