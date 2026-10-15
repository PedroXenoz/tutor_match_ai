import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Reusable button. Filled green by default, or outlined if [outlined] is true.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool outlined;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outlined = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18),
          const SizedBox(width: 8),
        ],
        Text(label),
      ],
    );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );
    const padding = EdgeInsets.symmetric(horizontal: 24, vertical: 16);

    if (outlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: padding,
          shape: shape,
        ),
        child: content,
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: padding,
        shape: shape,
      ),
      child: content,
    );
  }
}
