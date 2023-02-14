class Room {
  static const String collectionName='rooms';
  String roomTitle;
  String roomDescription;
  String categoryId;
  String roomId;
  Room(
      {required this.roomDescription,
      required this.roomTitle,
      required this.roomId,
      required this.categoryId});

  Room.fromJson(Map<String, dynamic> json)
      : this(
            roomDescription: json['roomDescription'] as String,
            roomTitle: json['roomTitle'] as String,
            categoryId: json['id'] as String,
            roomId: json['room_Id'] as String);

  Map<String, dynamic> toJson() {
    return {
      'roomDescription': roomDescription,
      'roomTitle': roomTitle,
      'id': categoryId,
      'room_Id': roomId,
    };
  }
}
