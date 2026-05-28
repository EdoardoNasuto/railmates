import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class GroupsModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const GroupsModel({
    this.id,
    this.created_at,
    this.dates,
    this.days,
    this.mates,
    this.budget,
    this.unigender,
  });

  @NowaGenerated({'loader': 'auto-from-json'})
  factory GroupsModel.fromJson(Map<String, dynamic> json) {
    return GroupsModel(
      id: json['id'],
      created_at: json['created_at'],
      dates: json['dates'],
      days: json['days'],
      mates: json['mates'],
      budget: json['budget'],
      unigender: json['unigender'],
    );
  }

  final String? id;

  final String? created_at;

  final String? dates;

  final String? days;

  final String? mates;

  final String? budget;
  
  final bool? unigender;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': created_at,
      'dates': dates,
      'days': days,
      'mates': mates,
      'budget': budget,
      'unigender': unigender,
    };
  }
}
