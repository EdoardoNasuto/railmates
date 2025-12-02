import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/models/compatibility_sections_model.dart';

@NowaGenerated()
class CompatibilityQuestionsModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityQuestionsModel({
    this.id,
    this.code,
    this.multi_select,
    this.required,
    this.label,
    this.section_id,
  });

  @NowaGenerated({'loader': 'auto-from-json'})
  factory CompatibilityQuestionsModel.fromJson(Map<String, dynamic> json) {
    return CompatibilityQuestionsModel(
      id: json['id'],
      code: json['code'],
      multi_select: json['multi_select'],
      required: json['required'],
      label: json['label'],
      section_id: CompatibilitySectionsModel.fromJson(
        json['section_id'] ?? {},
      ),
    );
  }

  final int? id;

  final String? code;

  final bool? multi_select;

  final bool? required;

  final dynamic label;

  final CompatibilitySectionsModel? section_id;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'multi_select': multi_select,
      'required': required,
      'label': label,
      'section_id': section_id?.toJson(),
    };
  }
}
