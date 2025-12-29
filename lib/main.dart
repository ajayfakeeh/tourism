import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/di/injector.dart';
import 'package:location/presentation/cubit/auth/auth_cubit.dart';
import 'package:location/presentation/cubit/auth/auth_cubit.dart';
import 'package:location/presentation/pages/splash_screen.dart';
import 'package:location/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        // Other Cubits are provided locally in pages, but global ones could go here
      ],
      child: MaterialApp(
        title: 'Location App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
