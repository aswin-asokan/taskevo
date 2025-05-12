//user can login with email and password
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trelza_taskevo/features/auth/presentation/cubits/auth_cubits.dart';
import 'package:trelza_taskevo/features/auth/presentation/cubits/auth_state.dart';
import 'package:trelza_taskevo/shared/extension/app_theme_extension.dart';
import 'package:trelza_taskevo/shared/widgets/custom_button.dart';
import 'package:trelza_taskevo/shared/widgets/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void register() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final authcubit = context.read<AuthCubit>();
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        name.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        authcubit.register(name, email, password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Passwords do not match',
              style: context.textTheme.bodySmall,
            ),
            backgroundColor: context.colorScheme.secondary,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all fields',
            style: context.textTheme.bodySmall,
          ),
          backgroundColor: context.colorScheme.secondary,
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is Authenticated) {
          Navigator.pop(context); // Or nothing at all
        } else if (state is AuthError) {
          // Optional: show error here too if you want
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error, style: context.textTheme.bodySmall),
              backgroundColor: context.colorScheme.secondary,
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 50, right: 50, top: 100),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Icon(Icons.task_alt_rounded, size: 150),
                  SizedBox(height: 60),
                  CustomTextfield(
                    hintText: context.loc.name,
                    controller: nameController,
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 16),
                  CustomTextfield(
                    hintText: context.loc.email,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16),
                  CustomTextfield(
                    hintText: context.loc.password,
                    controller: passwordController,
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 16),
                  CustomTextfield(
                    hintText: context.loc.confirm_password,
                    controller: confirmPasswordController,
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 16),
                  CustomButton(text: context.loc.sign_up, onPressed: register),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
