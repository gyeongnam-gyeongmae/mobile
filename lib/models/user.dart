class User {
  final int id;
  final String nickname;

  User({
    required this.id,
    required this.nickname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      nickname: json['nickname'] as String,
    );
  }
}
