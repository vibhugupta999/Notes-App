import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.autoFocus = false,
    this.filled,
    this.fillColor,
    this.labelText,
    this.suffixIcon,
    this.obSecureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.none,
    this.keyboardType = TextInputType.text,
    this.validator
  });

  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onChanged;
  final bool autoFocus;
  final bool? filled;
  final Color? fillColor;
  final String? labelText;
  final Widget? suffixIcon;
  final bool obSecureText;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autoFocus,
      onChanged: onChanged,
      cursorColor: Colors.black87,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).primaryColorDark,
        ),

        contentPadding: EdgeInsets.all(16),
        filled: filled,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      obscureText: obSecureText,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
