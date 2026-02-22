import 'package:railmates/models/countries_model.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class CompatibilityDestinationsModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityDestinationsModel({this.profile_id, this.country_id});

  @NowaGenerated({'loader': 'auto-from-json'})
  factory CompatibilityDestinationsModel.fromJson(Map<String, dynamic> json) {
    return CompatibilityDestinationsModel(
      profile_id: json['profile_id'],
      country_id: CountriesModel.fromJson(json['country_id'] ?? {}),
    );
  }

  final String? profile_id;

  final CountriesModel? country_id;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {'profile_id': profile_id, 'country_id': country_id?.id};
  }
}
