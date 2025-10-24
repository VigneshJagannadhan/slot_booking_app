import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/register_screen.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/password_text_form_field.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/primary_button.dart';
import 'package:slot_booking_app/features/home/presentation/screens/home_screen.dart';
import 'package:slot_booking_app/core/utils/app_styles.dart';
import 'package:slot_booking_app/core/utils/app_validators.dart';
import 'package:slot_booking_app/core/utils/snackbar_helper.dart';

class LoginScreen extends StatelessWidget {
  static const String route = 'login';
  LoginScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(
    text: 'test@gmail.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: 'Abcd@1234',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(255, 148, 29, 188),
              ],
            ),
          ),

          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withValues(alpha: 0.06),
                          Colors.white.withValues(alpha: 0.02),
                        ],
                      ),
                      color: Colors.white.withValues(alpha: 0.04),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 10.r,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Login',
                            style: AppStyles.ts28CFFFFFFW600,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CustomTextFormField(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          prefixIcon: Icons.email,
                          controller: _emailController,
                          validator: AppValidators.validateEmail,
                        ),
                        SizedBox(height: 20.h),
                        PasswordTextFormField(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          controller: _passwordController,
                          validator: AppValidators.validatePassword,
                        ),
                        SizedBox(height: 20.h),

                        BlocConsumer<AuthBloc, AuthState>(
                          listener: _listenToAuthChanges,
                          builder: (context, state) {
                            return PrimaryButton(
                              isLoading: state is AuthLoading,
                              label: 'Login',
                              onPressed: () => _onLoginButtonPressed(context),
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        TextButton(
                          onPressed:
                              () => _onCreateAccountButtonPressed(context),
                          child: Text(
                            'Create an account',
                            style: AppStyles.ts12CFFFFFFW400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _onCreateAccountButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  void _onLoginButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  void _listenToAuthChanges(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
        }
      });
    }
    if (state is AuthFailure) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          SnackbarHelper.showSnackbar(
            context: context,
            message: state.failure.message,
            isError: true,
          );
        }
      });
    }
  }
}
