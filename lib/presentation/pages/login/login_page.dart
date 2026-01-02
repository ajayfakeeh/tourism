import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/presentation/cubit/auth/auth_cubit.dart';
import 'package:location/presentation/cubit/auth/auth_state.dart';
import 'package:location/presentation/pages/main_screen/main_screen.dart';
import 'package:location/presentation/pages/login/widgets/login_header.dart';
import 'package:location/presentation/pages/login/widgets/email_input.dart';
import 'package:location/presentation/pages/login/widgets/password_input.dart';
import 'package:location/presentation/pages/login/widgets/login_button.dart';
import 'package:location/presentation/pages/login/widgets/login_footer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LoginHeader(),
                    EmailInput(controller: _emailController),
                    const SizedBox(height: 24),
                    PasswordInput(controller: _passwordController),
                    const SizedBox(height: 40),
                    LoginButton(
                      onPressed: _onLoginPressed,
                      isLoading: state is AuthLoading,
                    ),
                    const SizedBox(height: 24),
                    const LoginFooter(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
