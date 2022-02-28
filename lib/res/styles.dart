import 'package:flutter/material.dart';

import 'colors.dart';
import 'Dimens.dart';

class AppTextStyles {
  static const TextStyle textSize12 = TextStyle(
    fontSize: AppDimens.font_sp12,
  );
  static const TextStyle textSize16 = TextStyle(
    fontSize: AppDimens.font_sp16,
  );
  static const TextStyle textBold14 =
      TextStyle(fontSize: AppDimens.font_sp14, fontWeight: FontWeight.bold);
  static const TextStyle textBold16 =
      TextStyle(fontSize: AppDimens.font_sp16, fontWeight: FontWeight.bold);
  static const TextStyle textBold18 =
      TextStyle(fontSize: AppDimens.font_sp18, fontWeight: FontWeight.bold);
  static const TextStyle textBold24 =
      TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
  static const TextStyle textBold26 =
      TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold);

  static const TextStyle textGray14 = TextStyle(
    fontSize: AppDimens.font_sp14,
    color: AppColors.text_gray,
  );
  static const TextStyle textDarkGray14 = TextStyle(
    fontSize: AppDimens.font_sp14,
    color: AppColors.dark_text_gray,
  );

  static const TextStyle textWhite14 = TextStyle(
    fontSize: AppDimens.font_sp14,
    color: Colors.white,
  );

  static const TextStyle text = TextStyle(
      fontSize: AppDimens.font_sp14,
      color: AppColors.text,
      // https://github.com/flutter/flutter/issues/40248
      textBaseline: TextBaseline.alphabetic);
  static const TextStyle textDark = TextStyle(
      fontSize: AppDimens.font_sp14,
      color: AppColors.dark_text,
      textBaseline: TextBaseline.alphabetic);

  static const TextStyle textGray12 = TextStyle(
      fontSize: AppDimens.font_sp12,
      color: AppColors.text_gray,
      fontWeight: FontWeight.normal);
  static const TextStyle textDarkGray12 = TextStyle(
      fontSize: AppDimens.font_sp12,
      color: AppColors.dark_text_gray,
      fontWeight: FontWeight.normal);

  static const TextStyle textHint14 = TextStyle(
      fontSize: AppDimens.font_sp14,
      color: AppColors.dark_unselected_item_color);
}
