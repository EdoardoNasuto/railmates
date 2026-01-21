import 'package:railmates/models/profiles_model.dart';
import 'package:railmates/models/compatibility_options_model.dart';
import 'package:railmates/models/compatibility_questions_model.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class CompatibilityAnswersModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityAnswersModel({
    this.profile_id,
    this.option_id,
    this.question_id,
    this.created_at,
  });

  @NowaGenerated({'loader': 'auto-from-json'})
  factory CompatibilityAnswersModel.fromJson(Map<String, dynamic> json) {
    return CompatibilityAnswersModel(
      profile_id: ProfilesModel.fromJson(json['profile_id'] ?? {}),
      option_id: CompatibilityOptionsModel.fromJson(
        json['option_id'] ?? {},
      ),
      question_id: CompatibilityQuestionsModel.fromJson(
        json['question_id'] ?? {},
      ),
      created_at: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  final ProfilesModel? profile_id;

  final CompatibilityOptionsModel? option_id;

  final CompatibilityQuestionsModel? question_id;

  final DateTime? created_at;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {
      'profile_id': profile_id?.toJson(),
      'option_id': option_id?.toJson(),
      'question_id': question_id?.toJson(),
      'created_at': created_at?.toIso8601String(),
    };
  }
}
