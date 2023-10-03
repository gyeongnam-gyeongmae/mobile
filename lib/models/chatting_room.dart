class ChattingRoom {
  final String updatedAt;
  final int id;

  ChattingRoom({
    required this.updatedAt,
    required this.id,
  });

  factory ChattingRoom.fromJson(Map<String, dynamic> json) {
    return ChattingRoom(
      updatedAt: json['updatedAt'] as String,
      id: json['id'] as int,
    );
  }
}
