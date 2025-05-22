import 'package:flutter/cupertino.dart';

abstract interface class ILocalizationUtil {
  void setLocale(
    BuildContext context, {
    required String langCode,
  });
}
