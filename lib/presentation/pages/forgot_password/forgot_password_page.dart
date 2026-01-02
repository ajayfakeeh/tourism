import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/presentation/cubit/auth/auth_cubit.dart';
import 'package:location/presentation/cubit/auth/auth_state.dart';
import 'package:location/presentation/pages/forgot_password/widgets/back_to_login_link.dart';
import 'package:location/presentation/pages/forgot_password/widgets/email_input.dart';
import 'package:location/presentation/pages/forgot_password/widgets/forgot_password_header.dart';
import 'package:location/presentation/pages/forgot_password/widgets/send_code_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSendCode() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().forgotPassword(_emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is PasswordResetSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Reset code sent to your email',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black87,
              ),
            );
            // Optionally navigate to a verification page or stay here
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ForgotPasswordHeader(),
                    const SizedBox(height: 48),
                    EmailInput(controller: _emailController),
                    const SizedBox(height: 32),
                    SendCodeButton(
                      onPressed: _onSendCode,
                      isLoading: state is AuthLoading,
                    ),
                    const SizedBox(height: 100), // Spacer
                    const BackToLoginLink(),
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
