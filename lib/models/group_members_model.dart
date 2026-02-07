import 'package:railmates/models/groups_model.dart';
import 'package:railmates/models/profiles_model.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class GroupMembersModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const GroupMembersModel({this.group_id, this.user_id});

  @NowaGenerated({'loader': 'auto-from-json'})
  factory GroupMembersModel.fromJson(Map<String, dynamic> json) {
    return GroupMembersModel(
      group_id: GroupsModel.fromJson(json['group_id'] ?? {}),
      user_id: ProfilesModel.fromJson(json['user_id'] ?? {}),
    );
  }

  final GroupsModel? group_id;

  final ProfilesModel? user_id;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {'group_id': group_id?.toJson(), 'user_id': user_id?.toJson()};
  }
}
