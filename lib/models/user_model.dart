import 'dart:convert';

class UserModel {
  String id;
  String email;
  String password;
  String firstName;
  String lastName;
  String profilePhoto;
  DateTime dateOfBirth;
  int gender;
  DateTime joinDate;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.profilePhoto,
    required this.dateOfBirth,
    required this.gender,
    required this.joinDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'profile_photo': profilePhoto,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'join_date': joinDate.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      profilePhoto: map['profile_photo'],
      dateOfBirth: map['date_of_birth'],
      gender: map['gender'] as int,
      joinDate: map['join_date'] as DateTime,
    );
  }

  String toJson() => json.encode(toMap());
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
