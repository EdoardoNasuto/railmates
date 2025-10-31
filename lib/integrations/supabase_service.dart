import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:railmates/integrations/supabase_enums.dart';
import 'dart:typed_data';
import 'package:railmates/models/profiles_model.dart';

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

  Future<PostgrestList> citiesStartingWith(
    String prefix, {
    SearchType type = SearchType.cities,
    int limit = 5,
  }) async {
    if (type == SearchType.cities) {
      final response = await Supabase.instance.client
          .from('cities')
          .select('id, name, native, state_name, country_id(name, flag_url)')
          .or('name.ilike.${prefix}%,native.ilike.${prefix}%')
          .limit(limit);
      return (response as List)
          .map(
            (city) => {
              'id': city['id'],
              'title': city['name'],
              'subtitle1': city['state_name'],
              'subtitle2': ', ${city['country_id']['name']}',
              'icon': city['country_id']['flag_url'],
            },
          )
          .toList();
    } else {
      if (type == SearchType.countries) {
        final response = await Supabase.instance.client
            .from('countries')
            .select('id, name, native, flag_url, population')
            .or('name.ilike.${prefix}%,native.ilike.${prefix}%')
            .order('population', ascending: false)
            .limit(limit);
        return (response as List)
            .map(
              (country) => {
                'id': country['id'],
                'title': country['name'],
                'subtitle1': country['native'],
                'icon': country['flag_url'],
              },
            )
            .toList();
      } else {
        throw Exception('Type de recherche non supporté : ${type}');
      }
    }
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
}
