import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.validator,
  });

  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  final ValueNotifier<bool> _isVisible = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isVisible,
      builder: (context, isVisible, _) {
        return TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          style: AppStyles.ts12CFFFFFFW500,
          obscureText: isVisible,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            labelStyle: AppStyles.ts12CFFFFFFW500,
            hintStyle: AppStyles.ts12CFFFFFFW500,
            prefixIcon: Icon(Icons.password),
            suffixIcon: GestureDetector(
              onTap: () => _isVisible.value = !_isVisible.value,
              child: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        );
      },
    );
  }
}
