import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final TextInputType? inputType;
  final String? prefix;
  final ValueChanged<String> onChanged;

  const AuthTextField({
    super.key,
    required this.hint,
    this.inputType,
    this.prefix,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      cursorColor: AppColors.primaryOrange,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.surface,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        prefixIcon: prefix != null
            ? Padding(
                padding: const EdgeInsets.only(left: 15, right: 8),
                child: Text(prefix!, style: AppStyles.bodyLarge),
              )
            : null,
        prefixIconConstraints: prefix != null
            ? const BoxConstraints(minWidth: 0, minHeight: 0)
            : null,
      ),
      onChanged: onChanged,
    );
  }
}
