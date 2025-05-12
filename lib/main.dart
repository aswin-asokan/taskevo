import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trelza_taskevo/features/auth/data/firebase_auth_repo.dart';
import 'package:trelza_taskevo/features/auth/presentation/cubits/auth_cubits.dart';
import 'package:trelza_taskevo/features/auth/presentation/cubits/auth_state.dart';
import 'package:trelza_taskevo/features/auth/presentation/pages/login_page.dart';
import 'package:trelza_taskevo/features/home/presentation/pages/home.dart';
import 'package:trelza_taskevo/firebase_options.dart';
import 'package:trelza_taskevo/core/theme/light_mode.dart';
import 'package:trelza_taskevo/core/theme/dark_mode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trelza_taskevo/shared/extension/app_theme_extension.dart';
import 'package:trelza_taskevo/shared/widgets/loading.dart';

void main() async {
  //fire base setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //main app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final firebaseAuthRepo = FirebaseAuthRepo();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //provide cubits to the app
      providers: [
        BlocProvider<AuthCubit>(
          create:
              (context) => AuthCubit(authRepo: firebaseAuthRepo)..authCheck(),
        ),
      ],
      child: MaterialApp(
        title: 'Trelza TaskEvo',
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English
          Locale('es'), // Spanish
        ],
        debugShowCheckedModeBanner: false,
        theme: lightmode,
        darkTheme: darkmode,
        home: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              // show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error,
                    style: context.textTheme.bodySmall,
                  ),
                  backgroundColor: context.colorScheme.secondary,
                ),
              );
            }
          },
          builder: (context, state) {
            print(state);
            // unauthenticated state
            if (state is Unauthenticated) {
              // navigate to login page
              return LoginPage();
            }
            // authenticated state
            if (state is Authenticated) {
              return Home();
            } else if (state is AuthError) {
              return LoginPage();
            } else {
              return Loading();
            }
          },
        ),
      ),
    );
  }
}
