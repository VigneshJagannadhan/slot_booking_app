import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/features/auth/bloc/visibility/visibility_bloc.dart';

class PasswordTextFormField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocBuilder<VisibilityBloc, VisibilityState>(
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          validator: validator,
          obscureText: state is VisibilityOffState,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            prefixIcon: Icon(Icons.password),
            suffixIcon: GestureDetector(
              onTap:
                  () => context.read<VisibilityBloc>().add(
                    VisibilityToggleEvent(),
                  ),
              child: Icon(
                state is VisibilityOnState
                    ? Icons.visibility
                    : Icons.visibility_off,
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
