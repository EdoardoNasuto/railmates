import 'package:railmates/models/profiles_model.dart';
import 'package:railmates/models/compatibility_options_model.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class CompatibilityAnswersModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityAnswersModel({
    this.id,
    this.profile_id,
    this.option_id,
    this.question_id,
  });

  @NowaGenerated({'loader': 'auto-from-json'})
  factory CompatibilityAnswersModel.fromJson(Map<String, dynamic> json) {
    return CompatibilityAnswersModel(
      id: json['id'],
      profile_id: ProfilesModel.fromJson(json['profile_id'] ?? {}),
      option_id: CompatibilityOptionsModel.fromJson(
        json['option_id'] ?? {},
      ),
      question_id: json['question_id'],
    );
  }

  final String? id;

  final ProfilesModel? profile_id;

  final CompatibilityOptionsModel? option_id;

  final int? question_id;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile_id': profile_id?.toJson(),
      'option_id': option_id?.toJson(),
      'question_id': question_id,
    };
  }
}
