import 'package:flutter/material.dart';
import 'package:trelza_taskevo/shared/extension/app_theme_extension.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: context.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
        child: Text(
          text,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
