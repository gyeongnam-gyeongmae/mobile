class User {
  final int id;
  final String nickname;
  final String url;

  User({
    required this.id,
    required this.nickname,
    required this.url,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      nickname: json['nickname'] as String,
      url: json['profileImageUrl'] as String,
    );
  }
}
