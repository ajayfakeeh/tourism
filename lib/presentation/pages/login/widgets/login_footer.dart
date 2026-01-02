import 'package:flutter/material.dart';
import 'package:location/presentation/pages/registration/registration_page.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const primaryGreen = Color(0xFF00E676);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("New here? ", style: textTheme.bodyMedium),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RegistrationPage()),
            );
          },
          child: Text(
            "Create an account",
            style: textTheme.bodyMedium?.copyWith(
              color: primaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
