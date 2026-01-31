import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class CompatibilityModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityModel({
    this.user_id,
    this.personality,
    this.essential,
    this.destination,
    this.start_date,
    this.end_date,
    this.min_days = 0,
    this.max_days = 0,
  });

  @NowaGenerated({'loader': 'auto-from-json'})
  factory CompatibilityModel.fromJson(Map<String, dynamic> json) {
    return CompatibilityModel(
      user_id: json['user_id'],
      personality: json['personality'],
      essential: json['essential'],
      destination: json['destination'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      min_days: json['min_days'],
      max_days: json['max_days'],
    );
  }

  final String? user_id;

  final String? personality;

  final String? essential;

  final String? destination;

  final String? start_date;

  final String? end_date;

  final int? min_days;

  final int? max_days;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'personality': personality,
      'essential': essential,
      'destination': destination,
      'start_date': start_date,
      'end_date': end_date,
      'min_days': min_days,
      'max_days': max_days,
    };
  }
}
