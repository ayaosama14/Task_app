// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  Function() onPressed;
  CustomButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 12),
        foregroundColor: Colors.cyan,
      ),
      onPressed: onPressed,
      child: const Text(
        'Add',
        style: TextStyle(color: Colors.black, fontSize: 30),
      ),
    );
  }
}
