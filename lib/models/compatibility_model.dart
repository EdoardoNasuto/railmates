import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class CompatibilityModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityModel({
    this.user_id,
    this.personality,
    this.destination,
    this.dates,
    this.days,
    this.mates,
    this.budget,
    this.ready = false,
    this.complete = false,
  });

  @NowaGenerated({'loader': 'auto-from-json'})
  factory CompatibilityModel.fromJson(Map<String, dynamic> json) {
    return CompatibilityModel(
      user_id: json['user_id'],
      personality: json['personality'],
      destination: json['destination'],
      dates: json['dates'],
      days: json['days'],
      mates: json['mates'],
      budget: json['budget'],
      ready: json['ready'] ?? false,
      complete: json['complete'] ?? false,
    );
  }

  final String? user_id;

  final String? personality;

  final dynamic destination;

  final String? dates;

  final String? days;

  final String? mates;

  final String? budget;

  final bool? ready;

  final bool? complete;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'personality': personality,
      'destination': destination,
      'dates': dates,
      'days': days,
      'mates': mates,
      'budget': budget,
      'ready': ready,
      'complete': complete,
    };
  }
}
