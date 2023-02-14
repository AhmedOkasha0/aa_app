class MyUser {

  static const String collectionName='users';
  String id;
  String firstName;
  String lastName;
  String userName;
  String email;
  MyUser(
      {required this.email,
      required this.id,
      required this.userName,
      required this.lastName,
      required this.firstName});
  MyUser.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          firstName: json['firstName'] as String,
          lastName: json['lastName'] as String,
          userName: json['userName'] as String,
          email: json['email'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}
/// data class to send and receive data
