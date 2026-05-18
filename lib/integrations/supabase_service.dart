import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:railmates/firebase/notification_service.dart';
import 'package:railmates/globals/app_constants.dart';
import 'package:railmates/models/profiles_model.dart';
import 'package:railmates/models/cities_model.dart';
import 'package:railmates/models/countries_model.dart';
import 'package:railmates/models/compatibility_questions_model.dart';
import 'package:railmates/models/compatibility_options_model.dart';
import 'package:railmates/models/compatibility_answers_model.dart';
import 'package:railmates/models/compatibility_model.dart';
import 'package:railmates/models/compatibility_destinations_model.dart';
import 'package:railmates/models/group_members_model.dart';
import 'package:railmates/models/group_destinations_model.dart';

@NowaGenerated()
class SupabaseService {
  SupabaseService._();

  factory SupabaseService() {
    return _instance;
  }

  static final SupabaseService _instance = SupabaseService._();

  bool isConnected() {
    return Supabase.instance.client.auth.currentUser != null;
  }

  Future initialize() async {
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
    );
  }

  Future<AuthResponse> signIn(String email, String password) async {
    final response = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    try {
      final fcm = NotificationService.instance.fcmToken;
      await SupabaseService().updateProfiles(
        ProfilesModel(fcm_token: fcm),
      );
    } catch (e) {}
    return response;
  }

  Future<AuthResponse> signUp(String email, String password) async {
    final response = await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );
    try {
      final fcm = NotificationService.instance.fcmToken;
      await SupabaseService().updateProfiles(
        ProfilesModel(fcm_token: fcm),
      );
    } catch (e) {}
    return response;
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
  }

  Future<void> resetPasswordForEmail(dynamic email) async {
    await Supabase.instance.client.auth.resetPasswordForEmail(email);
  }

  Future<ResendResponse> resend(String email, OtpType type) async {
    return await Supabase.instance.client.auth.resend(email: email, type: type);
  }

  Future<AuthResponse> verifyOTP(
    String email,
    String token,
    OtpType type,
  ) async {
    return await Supabase.instance.client.auth.verifyOTP(
      email: email,
      token: token,
      type: type,
    );
  }

  Future<UserResponse> updateUser(String? email, String? password) async {
    return await Supabase.instance.client.auth.updateUser(
      UserAttributes(email: email, password: password),
    );
  }

  Future<ProfilesModel> updateProfiles(ProfilesModel data) async {
    final response = await Supabase.instance.client
        .from('profiles')
        .update(data.toJson()..removeWhere((key, value) => value == null))
        .eq('id', Supabase.instance.client.auth.currentUser!.id)
        .select('*')
        .single();
    return ProfilesModel.fromJson(response);
  }

  Future<List<CitiesModel>> getByPrefixCities(
    String prefix, {
    int limit = 5,
  }) async {
    final response = await Supabase.instance.client
        .from('cities')
        .select(
          'id, name, native, state_name, country_id(name, flag_url, population)',
        )
        .or('name.ilike.${prefix}%,native.ilike.${prefix}%')
        .limit(limit);
    return response.map((json) => CitiesModel.fromJson(json)).toList();
  }

  Future<CitiesModel?> getByIdCities(int id) async {
    final response = await Supabase.instance.client
        .from('cities')
        .select('*, country_id(name)')
        .eq('id', id)
        .maybeSingle();
    return response != null ? CitiesModel.fromJson(response!) : null;
  }

  Future<List<CountriesModel>> getAllCountries() async {
    final response = await Supabase.instance.client
        .from('countries')
        .select('*')
        .order('population');
    return response.map((json) => CountriesModel.fromJson(json)).toList();
  }

  Future<List<CountriesModel>> getByPrefixCountries(
    String prefix, {
    int limit = 5,
  }) async {
    final response = await Supabase.instance.client
        .from('countries')
        .select('id, name, native, subregion, flag_url, population')
        .or('name.ilike.${prefix}%,native.ilike.${prefix}%')
        .order('population')
        .limit(limit);
    return response.map((json) => CountriesModel.fromJson(json)).toList();
  }

  Future<CompatibilityQuestionsModel?> getByPosCompatibility_question(
    int pos,
  ) async {
    final response = await Supabase.instance.client
        .from('compatibility_questions')
        .select('*, section_id(*)')
        .eq('pos', pos)
        .maybeSingle();
    return response != null
        ? CompatibilityQuestionsModel.fromJson(response!)
        : null;
  }

  Future<List<CompatibilityOptionsModel>> getByPosCompatibility_options(
    int pos,
  ) async {
    final response = await Supabase.instance.client
        .from('compatibility_options')
        .select('*, question_id!inner(*)')
        .eq('question_id.pos', pos)
        .order('value');
    return response
        .map((json) => CompatibilityOptionsModel.fromJson(json))
        .toList();
  }

  Future<List<CompatibilityAnswersModel>> createCompatibility_answers(
    List<int> selectedIds,
  ) async {
    final records = selectedIds.map((id) => {'option_id': id}).toList();
    final response = await Supabase.instance.client
        .from('compatibility_answers')
        .insert(records)
        .select('*');
    final data = response as List<dynamic>;
    return data
        .map((json) => CompatibilityAnswersModel.fromJson(json))
        .toList();
  }

  Future<void> deleteCompatibility_answers(int question_id) async {
    await Supabase.instance.client
        .from('compatibility_answers')
        .delete()
        .eq('question_id', question_id);
  }

  Future<List<CompatibilityAnswersModel>> getByQuestionPosCompatibility_answers(
    int pos,
  ) async {
    final response = await Supabase.instance.client
        .from('compatibility_answers')
        .select('*, option_id(*), question_id!inner(pos)')
        .eq('question_id.pos', pos);
    return response
        .map((json) => CompatibilityAnswersModel.fromJson(json))
        .toList();
  }

  Future<CompatibilityModel?> getByIdCompatibility_availability() async {
    final response = await Supabase.instance.client
        .from('compatibility')
        .select('*')
        .maybeSingle();
    return response != null ? CompatibilityModel.fromJson(response!) : null;
  }

  Future<CompatibilityDestinationsModel> createCompatibility_destinations(
    CompatibilityDestinationsModel data,
  ) async {
    final response = await Supabase.instance.client
        .from('compatibility_destinations')
        .insert(data.toJson())
        .select('*')
        .single();
    return CompatibilityDestinationsModel.fromJson(response);
  }

  Future<void> deleteCompatibility_destinations() async {
    await Supabase.instance.client
        .from('compatibility_destinations')
        .delete()
        .eq('profile_id', Supabase.instance.client.auth.currentUser!.id);
  }

  Future<List<CompatibilityDestinationsModel>>
      getAllCompatibility_destinations() async {
    final response = await Supabase.instance.client
        .from('compatibility_destinations')
        .select('*, country_id(*)');
    return response
        .map((json) => CompatibilityDestinationsModel.fromJson(json))
        .toList();
  }

  Future<CompatibilityModel> createCompatibility(
    CompatibilityModel data,
  ) async {
    final response = await Supabase.instance.client
        .from('compatibility')
        .upsert(data.toJson())
        .select('*')
        .single();
    return CompatibilityModel.fromJson(response);
  }

  Future<CompatibilityModel> updateCompatibility(
    CompatibilityModel data,
  ) async {
    final response = await Supabase.instance.client
        .from('compatibility')
        .update(data.toJson()..removeWhere((key, value) => value == null))
        .eq('user_id', Supabase.instance.client.auth.currentUser!.id)
        .select('*')
        .single();
    return CompatibilityModel.fromJson(response);
  }

  Future<List<GroupMembersModel>> getAllGroup_members() async {
    final response = await Supabase.instance.client
        .from('group_members')
        .select('*, user_id(*)');
    return response.map((json) => GroupMembersModel.fromJson(json)).toList();
  }

  Future<List<GroupDestinationsModel>> getAllGroup_destinations() async {
    final response = await Supabase.instance.client
        .from('group_destinations')
        .select('*, countries_id(*)')
        .order('counts');
    return response
        .map((json) => GroupDestinationsModel.fromJson(json))
        .toList();
  }

  Future<CompatibilityModel?> getUserCompatibility() async {
    final response = await Supabase.instance.client
        .from('compatibility')
        .select('*')
        .maybeSingle();
    return response != null ? CompatibilityModel.fromJson(response!) : null;
  }

  Future<List<CompatibilityAnswersModel>> getBySectionCompatibility_answers(
    int section,
  ) async {
    final response = await Supabase.instance.client
        .from('compatibility_answers')
        .select('*, question_id!inner(*), option_id(*)')
        .eq('question_id.section_id', section);
    return response
        .map((json) => CompatibilityAnswersModel.fromJson(json))
        .toList();
  }

  Future<ProfilesModel?> getUserProfile() async {
    final response = await Supabase.instance.client
        .from('profiles')
        .select('*')
        .eq('id', Supabase.instance.client.auth.currentUser!.id)
        .maybeSingle();
    return response != null ? ProfilesModel.fromJson(response!) : null;
  }

  Future<bool> getUserCompatibilityComplete() async {
    final response = await Supabase.instance.client
        .from('compatibility')
        .select('complete')
        .maybeSingle();
    return response != null && response?['complete'] == true;
  }
}
