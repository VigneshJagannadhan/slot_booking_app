import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/themes/app_colors.dart';
import 'package:slot_booking_app/core/utils/snackbar_helper.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_ui_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_ui_event.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_ui_state.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/liquid_glass_background.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/password_text_form_field.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/primary_button.dart';
import 'package:slot_booking_app/features/home/presentation/screens/home_screen.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';
import 'package:slot_booking_app/core/utils/app_validators.dart';

class RegisterScreen extends StatelessWidget {
  static const String route = 'register';
  RegisterScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(
    text: 'John Doe',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'test@gmail.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: 'Abcd@1234',
  );
  final TextEditingController _confirmPasswordController =
      TextEditingController(text: 'Abcd@1234');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthUIBloc, AuthModeState>(
        builder: (context, state) {
          bool isInLoginMode = state is AuthModeLogin;
          return Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [AppColors.primaryColor, AppColors.secondaryColor],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Spacer(),
                  LiquidGlassBackground(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            isInLoginMode
                                ? 'Welcome Back'
                                : 'Create a new account',
                            style: AppStyles.ts28CFFFFFFW600,
                          ),
                        ),
                        if (!isInLoginMode) SizedBox(height: 20.h),
                        if (!isInLoginMode)
                          CustomTextFormField(
                            labelText: 'Name',
                            hintText: 'Enter your name',
                            prefixIcon: Icons.person,
                            controller: _nameController,
                            validator: AppValidators.validateName,
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
                        if (!isInLoginMode) SizedBox(height: 20.h),
                        if (!isInLoginMode)
                          PasswordTextFormField(
                            labelText: 'Confirm Password',
                            hintText: 'Enter your confirm password',
                            controller: _confirmPasswordController,
                            validator:
                                (value) =>
                                    AppValidators.validateConfirmPassword(
                                      value,
                                      _passwordController.text,
                                    ),
                          ),
                        SizedBox(height: 20.h),
                        BlocConsumer<AuthBloc, AuthState>(
                          listener:
                              (ctx, state) => _authListener(
                                context: ctx,
                                state: state,
                                isInLoginMode: isInLoginMode,
                              ),
                          builder: (context, state) {
                            return PrimaryButton(
                              isLoading: state is AuthLoading,
                              label: isInLoginMode ? 'Login' : 'Register',
                              onPressed:
                                  () => _onSubmitButtonPressed(
                                    context: context,
                                    isInLoginMode: isInLoginMode,
                                  ),
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        TextButton(
                          onPressed: () => _onAuthModeButtonPressed(context),
                          child: Text(
                            isInLoginMode
                                ? 'Create an account'
                                : 'Already have an account? Login',
                            style: AppStyles.ts12CFFFFFFW400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onAuthModeButtonPressed(BuildContext context) {
    final authUiBloc = context.read<AuthUIBloc>();
    authUiBloc.add(AuthModeChanged());
  }

  void _onSubmitButtonPressed({
    required BuildContext context,
    required bool isInLoginMode,
  }) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        isInLoginMode
            ? LoginRequested(
              email: _emailController.text,
              password: _passwordController.text,
            )
            : RegisterRequested(
              name: _nameController.text,
              email: _emailController.text,
              password: _passwordController.text,
            ),
      );
    }
  }

  void _authListener({
    required BuildContext context,
    required AuthState state,
    required bool isInLoginMode,
  }) {
    if (state is AuthSuccess) {
      if (!isInLoginMode) {
        SnackbarHelper.showSnackbar(
          context: context,
          message: 'Register successful',
        );
      }

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
