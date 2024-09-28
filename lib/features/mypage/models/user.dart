class User {
  final String userName;

  User({required this.userName});

  // JSON 데이터를 기반으로 User 객체를 생성하는 메서드
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['username'] ?? '', // 'username' 대신 올바른 필드명 사용
    );
  }
}
