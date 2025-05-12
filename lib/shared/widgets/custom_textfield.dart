import 'package:flutter/material.dart';
import 'package:trelza_taskevo/shared/extension/app_theme_extension.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.isPassword = false,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool isPassword;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: obscureText,
      keyboardType: widget.keyboardType,
      style: context.textTheme.bodyMedium,
      decoration: InputDecoration(
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: context.colorScheme.inversePrimary,
                  ),
                )
                : null,
        hintText: widget.hintText,
        hintMaxLines: 1,
        hintStyle: context.textTheme.bodyMedium,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        filled: true,
        fillColor: context.colorScheme.secondary,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: context.colorScheme.secondary),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.secondary),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
