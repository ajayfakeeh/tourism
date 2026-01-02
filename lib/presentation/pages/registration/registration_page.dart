import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/presentation/cubit/auth/auth_cubit.dart';
import 'package:location/presentation/cubit/auth/auth_state.dart';
import 'package:location/presentation/pages/home/homepage.dart';
import 'package:location/presentation/pages/registration/widgets/registration_header.dart';
import 'package:location/presentation/pages/registration/widgets/name_input.dart';
import 'package:location/presentation/pages/registration/widgets/email_input.dart';
import 'package:location/presentation/pages/registration/widgets/password_input.dart';
import 'package:location/presentation/pages/registration/widgets/confirm_password_input.dart';
import 'package:location/presentation/pages/registration/widgets/terms_checkbox.dart';
import 'package:location/presentation/pages/registration/widgets/registration_button.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
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
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RegistrationHeader(),
                    const SizedBox(height: 32),
                    NameInput(controller: _nameController),
                    const SizedBox(height: 16),
                    EmailInput(controller: _emailController),
                    const SizedBox(height: 16),
                    PasswordInput(controller: _passwordController),
                    const SizedBox(height: 16),
                    ConfirmPasswordInput(
                      controller: _confirmPasswordController,
                      passwordController: _passwordController,
                    ),
                    const SizedBox(height: 24),
                    TermsCheckbox(
                      value: _agreedToTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreedToTerms = value ?? false;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    RegistrationButton(
                      onPressed: _agreedToTerms ? _onRegister : null,
                      isLoading: state is AuthLoading,
                    ),
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
