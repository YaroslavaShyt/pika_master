import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pika_master/domain/utils/ilocalization_util.dart';

class LocalizationUtil implements ILocalizationUtil {
  @override
  void setLocale(
    BuildContext context, {
    required String langCode,
  }) {
    context.setLocale(Locale(langCode));
  }
}
