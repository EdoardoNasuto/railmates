import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class ProfilesModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ProfilesModel({
    this.id,
    this.first_name,
    this.last_name,
    this.avatar_url,
    this.birth_date,
    this.city,
    this.phone,
  });

  @NowaGenerated({'loader': 'auto-from-json'})
  factory ProfilesModel.fromJson(Map<String, dynamic> json) {
    return ProfilesModel(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      avatar_url: json['avatar_url'],
      birth_date: json['birth_date'],
      city: json['city'],
      phone: json['phone'],
    );
  }

  final String? id;

  final String? first_name;

  final String? last_name;

  final String? avatar_url;

  final String? birth_date;

  final int? city;

  final String? phone;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'avatar_url': avatar_url,
      'birth_date': birth_date,
      'city': city,
      'phone': phone,
    };
  }
}
