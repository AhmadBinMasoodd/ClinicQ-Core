import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  final text;
  final VoidCallback ontap;
  const RoundedButton({super.key, required this.text, required this.ontap});

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14,horizontal: 24),
          decoration: BoxDecoration(
              color: Color(0xFF0078D7),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset:Offset (0,3)
              )
            ]
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
