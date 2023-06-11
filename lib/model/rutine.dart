import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class RutineModel {
  int? id;
  String? name;
  String? email;
  String? address;
  RutineModel({
    required this.id,
    this.name,
    this.email,
    this.address,
  });

  RutineModel copyWith({
    int? id,
    String? name,
    String? email,
    String? address,
  }) {
    return RutineModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'address': address,
    };
  }

  factory RutineModel.fromMap(Map<String, dynamic> map) {
    return RutineModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RutineModel.fromJson(String source) =>
      RutineModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
