// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Favorites {
  final int id;
  final GeoPoint location;
  final String photo;
  final String properyName;
  final String size;
  Favorites({
    required this.id,
    required this.location,
    required this.photo,
    required this.properyName,
    required this.size,
  });

  Favorites copyWith({
    int? id,
    GeoPoint? location,
    String? photo,
    String? properyName,
    String? size,
  }) {
    return Favorites(
      id: id ?? this.id,
      location: location ?? this.location,
      photo: photo ?? this.photo,
      properyName: properyName ?? this.properyName,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'location': location,
      'photo': photo,
      'properyName': properyName,
      'size': size,
    };
  }

  factory Favorites.fromMap(Map<String, dynamic> map) {
    return Favorites(
      id: map['id'] as int,
      location: map ['location'] as GeoPoint,
      photo: map['photo'] as String,
      properyName: map['properyName'] as String,
      size: map['size'] as String,
    );
  }
  factory Favorites.fromSnapshot(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Favorites(
      id: data['id'] as int,
      properyName: data['properyName'] as String,
      photo: data['photo'] as String,
      location: data['location'] as GeoPoint,
      size: data['size'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorites.fromJson(String source) => Favorites.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Favorites(id: $id, location: $location, photo: $photo, properyName: $properyName, size: $size)';
  }

  @override
  bool operator ==(covariant Favorites other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.location == location &&
      other.photo == photo &&
      other.properyName == properyName &&
      other.size == size;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      location.hashCode ^
      photo.hashCode ^
      properyName.hashCode ^
      size.hashCode;
  }
}
