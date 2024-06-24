import 'package:flutter/material.dart';

import '../../app_styles.dart';

class CustomizedInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final FocusNode focusNode;
  final bool obscureText;
  final VoidCallback onEditingComplete;
  final List<FormFieldValidator<String>>? validators;

  const CustomizedInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.focusNode,
    this.obscureText = false,
    required this.onEditingComplete,
    this.validators,
  }) : super(key: key);

  @override
  _CustomizedInputFieldState createState() => _CustomizedInputFieldState();
}

class _CustomizedInputFieldState extends State<CustomizedInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText && _obscureText,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorMaxLines: 5,
        errorStyle: tPoppinsRegular.copyWith(
          color: tRed,
        ),
        hintText: widget.hintText,
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        hintStyle: const TextStyle(
          fontSize: 14,
          height: 1,
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
        labelStyle: tPoppinsMedium.copyWith(
            color: const Color.fromARGB(255, 89, 85, 85),
            fontWeight: FontWeight.w400,
            fontSize: 14),
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: Colors.grey)
            : null,
        suffixIcon: widget.obscureText && widget.suffixIcon != null
            ? IconButton(
                icon: Icon(
                  _obscureText ? widget.suffixIcon : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      validator: (value) {
        if (widget.validators != null) {
          for (var validator in widget.validators!) {
            String? validationError = validator(value);
            if (validationError != null) {
              return validationError;
            }
          }
        }
        return null;
      },
      onEditingComplete: widget.onEditingComplete,
    );
  }
}
