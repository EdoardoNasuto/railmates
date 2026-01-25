import 'package:railmates/models/compatibility_sections_model.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class CompatibilityQuestionsModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityQuestionsModel({
    this.id,
    this.code,
    this.multi_select,
    this.label,
    this.section_id,
    this.pos,
  });

  @NowaGenerated({'loader': 'auto-from-json'})
  factory CompatibilityQuestionsModel.fromJson(Map<String, dynamic> json) {
    return CompatibilityQuestionsModel(
      id: json['id'],
      code: json['code'],
      multi_select: json['multi_select'],
      label: json['label'],
      section_id: CompatibilitySectionsModel.fromJson(
        json['section_id'] ?? {},
      ),
      pos: json['pos'],
    );
  }

  final int? id;

  final String? code;

  final bool? multi_select;

  final dynamic label;

  final CompatibilitySectionsModel? section_id;

  final int? pos;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'multi_select': multi_select,
      'label': label,
      'section_id': section_id?.toJson(),
      'pos': pos,
    };
  }
}
