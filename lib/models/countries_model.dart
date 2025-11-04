import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class CountriesModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CountriesModel({
    this.id,
    this.name,
    this.iso3,
    this.iso2,
    this.numeric_code,
    this.phonecode,
    this.capital,
    this.currency,
    this.currency_name,
    this.currency_symbol,
    this.tld,
    this.native,
    this.population,
    this.region,
    this.region_id,
    this.subregion,
    this.subregion_id,
    this.nationality,
    this.timezones,
    this.latitude,
    this.longitude,
    this.emoji,
    this.emojiU,
    this.wiki_dataId,
    this.flag_url,
  });

  @NowaGenerated({'loader': 'auto-from-json'})
  factory CountriesModel.fromJson(Map<String, dynamic> json) {
    return CountriesModel(
      id: json['id'],
      name: json['name'],
      iso3: json['iso3'],
      iso2: json['iso2'],
      numeric_code: json['numeric_code'],
      phonecode: json['phonecode'],
      capital: json['capital'],
      currency: json['currency'],
      currency_name: json['currency_name'],
      currency_symbol: json['currency_symbol'],
      tld: json['tld'],
      native: json['native'],
      population: json['population'],
      region: json['region'],
      region_id: json['region_id'],
      subregion: json['subregion'],
      subregion_id: json['subregion_id'],
      nationality: json['nationality'],
      timezones: json['timezones'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      emoji: json['emoji'],
      emojiU: json['emojiU'],
      wiki_dataId: json['wiki_dataId'],
      flag_url: json['flag_url'],
    );
  }

  final int? id;

  final String? name;

  final String? iso3;

  final String? iso2;

  final int? numeric_code;

  final int? phonecode;

  final String? capital;

  final String? currency;

  final String? currency_name;

  final String? currency_symbol;

  final String? tld;

  final String? native;

  final int? population;

  final String? region;

  final int? region_id;

  final String? subregion;

  final int? subregion_id;

  final String? nationality;

  final String? timezones;

  final dynamic latitude;

  final dynamic longitude;

  final String? emoji;

  final String? emojiU;

  final String? wiki_dataId;

  final String? flag_url;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iso3': iso3,
      'iso2': iso2,
      'numeric_code': numeric_code,
      'phonecode': phonecode,
      'capital': capital,
      'currency': currency,
      'currency_name': currency_name,
      'currency_symbol': currency_symbol,
      'tld': tld,
      'native': native,
      'population': population,
      'region': region,
      'region_id': region_id,
      'subregion': subregion,
      'subregion_id': subregion_id,
      'nationality': nationality,
      'timezones': timezones,
      'latitude': latitude,
      'longitude': longitude,
      'emoji': emoji,
      'emojiU': emojiU,
      'wiki_dataId': wiki_dataId,
      'flag_url': flag_url,
    };
  }
}
