class UserModel {
  final String uid;
  final String email;
  final String username;
  final String role;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.role,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> data) {
    return UserModel(
      uid: uid,
      email: data['email'] ?? '',
      username: data['username'] ?? '',
      role: data['role'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'username': username, 'role': role};
  }
}
