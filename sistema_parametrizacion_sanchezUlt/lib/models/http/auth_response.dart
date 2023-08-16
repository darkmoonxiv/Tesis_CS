class AuthResponse {
  String status;
  String message;
  UserData data;

  AuthResponse({required this.status, required this.message, required this.data});

  factory AuthResponse.fromMap(Map<String, dynamic> json) {
    return AuthResponse(
      status: json['status'],
      message: json['message'],
      data: UserData.fromMap(json['data']),
    );
  }
}

class UserData {
  User user;
  String token;

  UserData({required this.user, required this.token});

  factory UserData.fromMap(Map<String, dynamic> json) {
    return UserData(
      user: User.fromMap(json['user']),
      token: json['token'],
    );
  }
}

class User {
  String email;
  String firstName;
  String lastName;

  User({required this.email, required this.firstName, required this.lastName});

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
