// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return UserModel(
      uid: id ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': uid,
      'email': email,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(id: $uid, email: $email, name: $name)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid && other.email == email && other.name == name;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode ^ name.hashCode;

  fold(NotLoginState Function(dynamic failure) param0,
      LoadedUserState Function(dynamic user) param1) {}
}
