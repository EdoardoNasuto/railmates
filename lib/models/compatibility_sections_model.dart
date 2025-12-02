import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class CompatibilitySectionsModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilitySectionsModel({this.id, this.code, this.label});

  @NowaGenerated({'loader': 'auto-from-json'})
  factory CompatibilitySectionsModel.fromJson(Map<String, dynamic> json) {
    return CompatibilitySectionsModel(
      id: json['id'],
      code: json['code'],
      label: json['label'],
    );
  }

  final int? id;

  final String? code;

  final dynamic label;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {'id': id, 'code': code, 'label': label};
  }
}
