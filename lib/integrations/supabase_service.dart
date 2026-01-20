import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:typed_data';
import 'package:railmates/models/profiles_model.dart';
import 'package:railmates/models/cities_model.dart';
import 'package:railmates/models/countries_model.dart';
import 'package:railmates/models/compatibility_questions_model.dart';
import 'package:railmates/models/compatibility_options_model.dart';
import 'package:railmates/models/compatibility_answers_model.dart';

@NowaGenerated()
class SupabaseService {
  SupabaseService._();

  factory SupabaseService() {
    return _instance;
  }

  static final SupabaseService _instance = SupabaseService._();

  Future initialize() async {
    await Supabase.initialize(
      url: 'https://ajepgfqpggsjwjvpwruh.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFqZXBnZnFwZ2dzandqdnB3cnVoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk3Nzc5MzUsImV4cCI6MjA3NTM1MzkzNX0.8JhJ9KTvGaGv4pFXpY_orgnKaMA0eHchFNuAfFR6i1w',
    );
  }

  Future<AuthResponse> signIn(String email, String password) async {
    return Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp(String email, String password) async {
    return Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );
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

  Future<void> avatarsUpload(Uint8List bytes) async {
    final String? uid = Supabase.instance.client.auth.currentUser?.id;
    if (uid == null) {
      throw Exception('User ID is null');
    }
    final String filePath = '${uid}/avatar.jpg';
    final storage = Supabase.instance.client.storage;
    final bucket = storage.from('avatars');
    try {
      await bucket.uploadBinary(
        filePath,
        bytes,
        fileOptions: const FileOptions(upsert: true),
      );
      await Supabase.instance.client
          .from('profiles')
          .update({'avatar_url': bucket.getPublicUrl(filePath)})
          .eq('id', uid!);
    } catch (e) {
      throw Exception('Erreur lors de l\'upload de l\'avatar : ${e}');
    }
  }

  Future<ProfilesModel> updateProfiles(ProfilesModel data) async {
    final response = await Supabase.instance.client
        .from('profiles')
        .update(data.toJson())
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

  Future<CompatibilityQuestionsModel?> getByIdCompatibility_question(
    int id,
  ) async {
    final response = await Supabase.instance.client
        .from('compatibility_questions')
        .select('*, section_id(*)')
        .eq('id', id)
        .maybeSingle();
    return response != null
        ? CompatibilityQuestionsModel.fromJson(response!)
        : null;
  }

  Future<List<CompatibilityOptionsModel>> getByIdCompatibility_options(
    int id,
  ) async {
    final response = await Supabase.instance.client
        .from('compatibility_options')
        .select('*, question_id(*)')
        .eq('question_id', id)
        .order('value');
    return response
        .map((json) => CompatibilityOptionsModel.fromJson(json))
        .toList();
  }

  Future<CompatibilityAnswersModel> createCompatibility_answers(
    int option_id,
  ) async {
    final response = await Supabase.instance.client
        .from('compatibility_answers')
        .insert({'option_id': option_id})
        .select('*')
        .single();
    return CompatibilityAnswersModel.fromJson(response);
  }

  Future<void> deleteCompatibility_answers(int option_id) async {
    await Supabase.instance.client
        .from('compatibility_answers')
        .delete()
        .eq('option_id', option_id);
  }
}
