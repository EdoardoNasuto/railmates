import 'package:railmates/models/countries_model.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class GroupDestinationsModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const GroupDestinationsModel({this.countries_id, this.counts, this.group_id});

  @NowaGenerated({'loader': 'auto-from-json'})
  factory GroupDestinationsModel.fromJson(Map<String, dynamic> json) {
    return GroupDestinationsModel(
      countries_id: CountriesModel.fromJson(json['countries_id'] ?? {}),
      counts: json['counts'],
      group_id: json['group_id'],
    );
  }

  final CountriesModel? countries_id;

  final int? counts;

  final String? group_id;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {
      'countries_id': countries_id?.toJson(),
      'counts': counts,
      'group_id': group_id,
    };
  }
}
