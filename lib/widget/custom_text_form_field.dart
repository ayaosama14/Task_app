// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  int maxline;
  TextEditingController myController;
  String hint;
  CustomTextField({
    Key? key,
    required this.maxline,
    required this.myController,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxline,
      controller: myController,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'field is required';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: hint,
        hintStyle: const TextStyle(color: Colors.cyan),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
