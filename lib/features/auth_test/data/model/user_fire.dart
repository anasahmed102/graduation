// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserFireStore {
  final String email;
  final String password;
  final String type;
  final String uid;
  UserFireStore({
    required this.email,
    required this.password,
    required this.type,
    required this.uid,
  });

  UserFireStore copyWith({
    String? email,
    String? password,
    String? type,
    String? uid,
  }) {
    return UserFireStore(
      email: email ?? this.email,
      password: password ?? this.password,
      type: type ?? this.type,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'type': type,
      'uid': uid,
    };
  }

  factory UserFireStore.fromMap(Map<String, dynamic> map) {
    return UserFireStore(
      email: map['email'] as String,
      password: map['password'] as String,
      type: map['type'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFireStore.fromJson(String source) => UserFireStore.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserFireStore(email: $email, password: $password, type: $type, uid: $uid)';
  }

  @override
  bool operator ==(covariant UserFireStore other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password &&
      other.type == type &&
      other.uid == uid;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      password.hashCode ^
      type.hashCode ^
      uid.hashCode;
  }
}
