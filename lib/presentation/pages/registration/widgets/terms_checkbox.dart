import 'package:flutter/material.dart';

class TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const TermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF00E676);
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Checkbox(
          value: value,
          activeColor: primaryGreen,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          onChanged: onChanged,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: textTheme.bodySmall,
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms of Service',
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const TextSpan(text: ' & '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
