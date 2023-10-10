class UserProfileModel{
  final int id;
  final String nickname;
  final String profileImageUrl;

  UserProfileModel({
    required this.id,
    required this.nickname,
    required this.profileImageUrl
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json){
    return UserProfileModel(
      id: json['id'],
      nickname: json['nickname'], 
      profileImageUrl: json['profileImageUrl']
      );
  }
}