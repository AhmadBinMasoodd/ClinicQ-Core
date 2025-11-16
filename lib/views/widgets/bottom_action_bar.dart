import 'package:flutter/material.dart';

class BottomActionBar extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const BottomActionBar({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.teal, // main color
            foregroundColor: Colors.white, // text/icon color
            elevation: 4,
          ).copyWith(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.teal.shade700;
              }
              return Colors.teal;
            }),
          ), child: null,
        ),
      ),
    );
  }
}
