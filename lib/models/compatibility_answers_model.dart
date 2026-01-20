import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class CompatibilityAnswersModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityAnswersModel({this.id, this.profile_id, this.option_id});

  @NowaGenerated({'loader': 'auto-from-json'})
  factory CompatibilityAnswersModel.fromJson(Map<String, dynamic> json) {
    return CompatibilityAnswersModel(
      id: json['id'],
      profile_id: json['profile_id'],
      option_id: json['option_id'],
    );
  }

  final String? id;

  final String? profile_id;

  final int? option_id;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {'id': id, 'profile_id': profile_id, 'option_id': option_id};
  }
}
