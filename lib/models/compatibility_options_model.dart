import 'package:railmates/models/compatibility_questions_model.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class CompatibilityOptionsModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityOptionsModel({
    this.id,
    this.question_id,
    this.label,
    this.description,
    this.value,
  });

  @NowaGenerated({'loader': 'auto-from-json'})
  factory CompatibilityOptionsModel.fromJson(Map<String, dynamic> json) {
    return CompatibilityOptionsModel(
      id: json['id'],
      question_id: CompatibilityQuestionsModel.fromJson(
        json['question_id'] ?? {},
      ),
      label: json['label'],
      description: json['description'],
      value: json['value'],
    );
  }

  final int? id;

  final CompatibilityQuestionsModel? question_id;

  final dynamic label;

  final dynamic description;

  final dynamic value;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_id': question_id?.toJson(),
      'label': label,
      'description': description,
      'value': value,
    };
  }
}
