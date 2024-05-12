// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class RealEstateModel {
  final int id;
  final String properyName;
  final String typeOfProperty;
  final String type;
  late final String photo;
  final GeoPoint location;
  final String price;
  File? imageFile;
  final String size;
  final String description;

  RealEstateModel({
    required this.id,
    required this.properyName,
    required this.typeOfProperty,
    required this.type,
    required this.photo,
    required this.location,
    required this.price,
    this.imageFile,
    required this.size,
    required this.description,
  });

  RealEstateModel copyWith({
    int? id,
    String? properyName,
    String? type,
    String? photo,
    GeoPoint? location,
    String? price,
    File? imageFile,
    String? size,
    String? description,
  }) {
    return RealEstateModel(
      typeOfProperty: typeOfProperty ,
      id: id ?? this.id,
      properyName: properyName ?? this.properyName,
      type: type ?? this.type,
      photo: photo ?? this.photo,
      location: location ?? this.location,
      price: price ?? this.price,
      imageFile: imageFile ?? this.imageFile,
      size: size ?? this.size,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      
      'id': id,
      'properyName': properyName,
      'type': type,
      'photo': photo,
      'location': location,
      'price': price,
      'imageFile': imageFile,
      'size': size,
      'description': description,
    };
  }

  factory RealEstateModel.fromMap(Map<String, dynamic> map) {
    return RealEstateModel(
      typeOfProperty:map['typeOfProperty'] as String ,
      id: map['id'] as int,
      type: map['type'] as String,
      properyName: map['properyName'] as String,
      photo: map['photo'] as String,
      location: map['location'] as GeoPoint,
      price: map['price'] as String,
      size: map['size'] as String,
      description: map['description'] as String,
    );
  }

  factory RealEstateModel.fromSnapshot(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RealEstateModel(
      typeOfProperty: data['typeOfProperty']as String,
      type: data['type'] as String,
      id: data['id'] as int,
      properyName: data['properyName'] as String,
      photo: data['photo'] as String,
      location: data['location'] as GeoPoint,
      price: data['price'] as String,
      size: data['size'] as String,
      description: data['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'RealEstateModel(id: $id, properyName: $properyName, type: $type, photo: $photo, location: $location, price: $price, imageFile: $imageFile, size: $size, description: $description typeOfProperty: $typeOfProperty,)';
  }

  @override
  bool operator ==(covariant RealEstateModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.properyName == properyName &&
        other.type == type &&
        other.photo == photo &&
        other.location == location &&
        other.price == price &&
        other.imageFile == imageFile &&
        other.size == size &&
                other.typeOfProperty == typeOfProperty &&

        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        properyName.hashCode ^
        type.hashCode ^
        photo.hashCode ^
        location.hashCode ^
        typeOfProperty.hashCode^
        price.hashCode ^
        imageFile.hashCode ^
        size.hashCode ^
        description.hashCode;
  }

  factory RealEstateModel.fromJson(String source) =>
      RealEstateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
