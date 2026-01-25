import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class CompatibilityAvailabilityModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityAvailabilityModel({
    this.user_id,
    this.start_date,
    this.end_date,
  });

  @NowaGenerated({'loader': 'auto-from-json'})
  factory CompatibilityAvailabilityModel.fromJson(Map<String, dynamic> json) {
    return CompatibilityAvailabilityModel(
      user_id: json['user_id'],
      start_date: json['start_date'],
      end_date: json['end_date'],
    );
  }

  final String? user_id;

  final String? start_date;

  final String? end_date;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {'user_id': user_id, 'start_date': start_date, 'end_date': end_date};
  }
}
