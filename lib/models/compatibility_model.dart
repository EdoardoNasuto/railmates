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
    this.min_days,
    this.max_days,
    this.min_mates,
    this.max_mates,
    this.min_budget,
    this.max_budget,
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
      min_mates: json['min_mates'],
      max_mates: json['max_mates'],
      min_budget: json['min_budget'],
      max_budget: json['max_budget'],
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

  final int? min_mates;

  final int? max_mates;

  final int? min_budget;

  final int? max_budget;

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
      'min_mates': min_mates,
      'max_mates': max_mates,
      'min_budget': min_budget,
      'max_budget': max_budget,
    };
  }
}
