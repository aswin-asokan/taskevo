//user can login with email and password
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trelza_taskevo/features/auth/presentation/cubits/auth_cubits.dart';
import 'package:trelza_taskevo/features/auth/presentation/pages/register_page.dart';
import 'package:trelza_taskevo/shared/extension/app_theme_extension.dart';
import 'package:trelza_taskevo/shared/widgets/custom_button.dart';
import 'package:trelza_taskevo/shared/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final authcubit = context.read<AuthCubit>();
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all fields',
            style: context.textTheme.bodySmall,
          ),
          backgroundColor: context.colorScheme.secondary,
        ),
      );
    } else {
      authcubit.login(email, password);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        context.loc.forgot_password,
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                CustomButton(text: context.loc.login, onPressed: login),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.loc.no_account,
                      style: context.textTheme.displayMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        context.loc.sign_up,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
