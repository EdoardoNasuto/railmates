import 'package:railmates/models/countries_model.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class CitiesModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CitiesModel({
    this.id,
    this.name,
    this.state_id,
    this.state_code,
    this.state_name,
    this.country_id,
    this.latitude,
    this.longitude,
    this.native,
    this.timezone,
    this.wikiDataId,
  });

  @NowaGenerated({'loader': 'auto-from-json'})
  factory CitiesModel.fromJson(Map<String, dynamic> json) {
    return CitiesModel(
      id: json['id'],
      name: json['name'],
      state_id: json['state_id'],
      state_code: json['state_code'],
      state_name: json['state_name'],
      country_id: CountriesModel.fromJson(json['country_id'] ?? {}),
      latitude: json['latitude'],
      longitude: json['longitude'],
      native: json['native'],
      timezone: json['timezone'],
      wikiDataId: json['wikiDataId'],
    );
  }

  final int? id;

  final String? name;

  final int? state_id;

  final String? state_code;

  final String? state_name;

  final CountriesModel? country_id;

  final dynamic latitude;

  final dynamic longitude;

  final String? native;

  final String? timezone;

  final String? wikiDataId;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'state_id': state_id,
      'state_code': state_code,
      'state_name': state_name,
      'country_id': country_id?.toJson(),
      'latitude': latitude,
      'longitude': longitude,
      'native': native,
      'timezone': timezone,
      'wikiDataId': wikiDataId,
    };
  }
}
