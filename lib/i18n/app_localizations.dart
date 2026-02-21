import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:flutter/material.dart';
import 'package:railmates/global_state.dart';

// Imports obligatoires (Dart a besoin de connaître les classes)
import 'package:railmates/i18n/app_localizations_en.dart';
import 'package:railmates/i18n/app_localizations_fr.dart';

@NowaGenerated()
abstract class AppLocalizations {
  static final Map<String, AppLocalizations> _registered = {
    'fr': AppLocalizationsFr(),
    'en': AppLocalizationsEn(),
  };

  static List<Locale> get supportedLocales {
    return _registered.keys.map((code) => Locale(code)).toList();
  }

  static AppLocalizations getByLocale(Locale locale) {
    return _registered[locale.languageCode] ?? _registered.values.first;
  }

  String get appTitle;
  String get login;
  String get signUp;
  String get createAccount;
  String get checkEmailVerification;
  String get createProfile;
  String get save;
  String get registrationSuccessful;
  String get passwordConfirmationMismatch;
  String get alreadyHaveAccount;
  String get email;
  String get password;
  String get confirmPassword;
  String get invalidFormat;
  String get passwordRequirements;
  String get loginSuccessful;
  String get emailSent;
  String get forgotPassword;
  String get notRegisteredYet;
  String welcome(String name);
  String get firstName;
  String get lastName;
  String get women;
  String get man;
  String get gender;
  String get fieldRequired;
  String get birthDate;
  String get city;
  String get phone;
  String get errorRaised;
  String get accountVerified;
  String get resendEmail;
  String get confirm;
  String get resendEmailQuestion;
  String get verify;
  String get otpLabel;
  String get resetPassword;
  String get passwordSuccessfullyChanged;
  String get newPassword;
  String get section;
  String get question;
  String get multipleAnswersPossible;
  String get option;
  String get description;
  String get dates;
  String get resultNameTemplate;
  String get resultDetailTemplate;
  String get essentialInformation;
  String get yourAvailability;
  String get idealTripDuration;
  String get numberOfMates;
  String get budget;
  String get incompleteInformation;
  String get favoriteCountries;
  String get chooseUpTo10Countries;
  String get onlyChoose10Countries;
  String get searchCity;

  static AppLocalizations of(BuildContext context) {
    return GlobalState.of(context).localizations;
  }
}
