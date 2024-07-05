import 'package:flutter/material.dart';
import 'package:m_stock_opname/utils/app_colors.dart';

class AppTheme {
  static InputDecoration getInputDecoration(String labelText) =>
      InputDecoration(
        filled: true,
        fillColor: AppColors.textfieldBackground,
        labelText: labelText,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
      );

  static InputDecoration getPasswordInputDecoration(String labelText) {
    bool visible = false;
    togglePasswordVisibility() {
      visible = !visible;
    }

    return InputDecoration(
      filled: true,
      fillColor: AppColors.textfieldBackground,
      labelText: labelText,
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          visible ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: togglePasswordVisibility,
      ),
    );
  }

  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        background: Colors.white,
        error: Colors.red,
        onTertiary: Colors.orange,
      ),
    );
  }

  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        background: Colors.white,
        error: Colors.red,
        onTertiary: Colors.orange,
      ),
    );
  }

  static BoxDecoration getRoundedContainer(
          {Color color = AppColors.textfieldBackground}) =>
      BoxDecoration(
          color: color,
          border: Border.all(
            color: color,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)));
}
