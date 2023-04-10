import 'address.dart';
import 'company.dart';

class UserModel {
  int? id;
  String? name;
  String? username;
  String? email;
  Address? address;
  String? phone;
  String? website;
  Company? company;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        username: json['username'] as String?,
        email: json['email'] as String?,
        address: json['address'] == null
            ? null
            : Address.fromJson(json['address'] as Map<String, dynamic>),
        phone: json['phone'] as String?,
        website: json['website'] as String?,
        company: json['company'] == null
            ? null
            : Company.fromJson(json['company'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'address': address?.toJson(),
        'phone': phone,
        'website': website,
        'company': company?.toJson(),
      };
}
