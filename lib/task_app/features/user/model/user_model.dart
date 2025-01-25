//Abstract class. Closed to modification.
abstract class UserModel {
  final String userId;
  final String displayName;
  final String email;
  final String joined;

  UserModel(
      {required this.userId,
      required this.displayName,
      required this.email,
      required this.joined});
}

//App User. This can be modified in future in case of new user features.
class UserM extends UserModel {
  UserM(
      {required super.userId,
      required super.displayName,
      required super.email,
      required super.joined});

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'display_name': displayName,
      'email': email,
      'created_at': joined,
    };
  }

  factory UserM.fromMap(Map<String, dynamic> map) {
    return UserM(
      userId: map['user_id'] ?? '',
      displayName: map['display_name'] ?? '',
      joined: map['created_at'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
