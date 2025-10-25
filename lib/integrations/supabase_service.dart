import 'package:nowa_runtime/nowa_runtime.dart';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  Future<PostgrestList> profilesUpdate({
    String? firstName,
    String? lastName,
    String? avatarUrl,
    String? birthDate,
    String? city,
  }) async {
    final String? userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User ID is null');
    }
    final Map<String, dynamic> values = {};
    if (firstName != null) values['first_name'] = firstName;
    if (lastName != null) values['last_name'] = lastName;
    if (avatarUrl != null) values['avatar_url'] = avatarUrl;
    if (birthDate != null) values['birth_date'] = birthDate;
    if (city != null) values['city'] = city;
    final response = await Supabase.instance.client
        .from('profiles')
        .update(values)
        .eq('id', userId)
        .select();
    return response;
  }

  Future<PostgrestList> citiesStartingWith(String prefix,
      [int limit = 5]) async {
    final response = await Supabase.instance.client
        .from('cities')
        .select('id, name, state_name, country_id(name, flag_url)')
        .ilike('name', '$prefix%')
        .limit(limit);
    return (response as List)
        .map((city) => {
              'id': city['id'],
              'name': city['name'],
              'state': city['state_name'],
              'country': city['country_id']['name'],
              'flag': city['country_id']['flag_url'],
            })
        .toList();
  }

  Future<void> avatarsUpload(Uint8List bytes) async {
    final String? uid = Supabase.instance.client.auth.currentUser?.id;
    if (uid == null) {
      throw Exception('User ID is null');
    }

    final String filePath = '$uid/avatar.jpg';
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
          .update({'avatar_url': bucket.getPublicUrl(filePath)}).eq('id', uid);
    } catch (e) {
      throw Exception("Erreur lors de l'upload de l'avatar : $e");
    }
  }
}
