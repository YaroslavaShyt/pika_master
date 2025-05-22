// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _en_GB = {
  "whoThatPokemon": "Who's that Pokemon?",
  "googleSignIn": "Sign in with Google",
  "leaderboard": "Leaderboard",
  "streak": {
    "days_in_a_row": "{} day(s) in a row!"
  },
  "oops": "Oops",
  "youCaughtIt": "You caught it! 🎉",
  "oopsItWas": {
    "pokemonName": "Oops! It was {} 😅\""
  },
  "back": "Back",
  "startAgain": "Start again",
  "startRound": "Start Round"
};
static const Map<String,dynamic> _uk_UA = {
  "whoThatPokemon": "Хто цей Покемон?",
  "googleSignIn": "Вхід з Google",
  "leaderboard": "Лідери",
  "streak": {
    "days_in_a_row": "{} дні підряд!"
  },
  "oops": "Халепа(",
  "youCaughtIt": "Ви спіймали його! 🎉",
  "oopsItWas": {
    "pokemonName": "Ой! Це був {} 😅\""
  },
  "back": "Назад",
  "startAgain": "Грати ще",
  "startRound": " Почати раунд"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_GB": _en_GB, "uk_UA": _uk_UA};
}
