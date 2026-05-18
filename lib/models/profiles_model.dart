import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class ProfilesModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const ProfilesModel({
    this.id,
    this.first_name,
    this.last_name,
    this.birth_date,
    this.city,
    this.phone,
    this.gender,
    this.fcm_token,
  });

  @NowaGenerated({'loader': 'auto-from-json'})
  factory ProfilesModel.fromJson(Map<String, dynamic> json) {
    return ProfilesModel(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      birth_date: json['birth_date'],
      city: json['city'],
      phone: json['phone'],
      gender: json['gender'],
      fcm_token: json['fcm_token'],
    );
  }

  final String? id;

  final String? first_name;

  final String? last_name;

  final String? birth_date;

  final int? city;

  final String? phone;

  final String? gender;

  final String? fcm_token;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'birth_date': birth_date,
      'city': city,
      'phone': phone,
      'gender': gender,
      'fcm_token': fcm_token,
    };
  }
}
