import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/features/auth/bloc/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/primary_button.dart';
import 'package:slot_booking_app/features/home/presentation/screens/home_screen.dart';
import 'package:slot_booking_app/utils/app_styles.dart';
import 'package:slot_booking_app/utils/app_validators.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: context.read<AuthBloc>(),
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
        }
        if (state is AuthError) {
          // Use a delayed callback to ensure Scaffold is available
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          });
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          body: Form(
            key: _formKey,
            child: Container(
              height: 1.sh,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Register', style: AppStyles.ts24C000W600),
                  SizedBox(height: 20.h),
                  CustomTextFormField(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icons.email,
                    controller: _emailController,
                    validator: AppValidators.validateEmail,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFormField(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icons.password,
                    controller: _passwordController,
                    validator: AppValidators.validatePassword,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFormField(
                    labelText: 'Confirm Password',
                    hintText: 'Enter your confirm password',
                    prefixIcon: Icons.password,
                    controller: _confirmPasswordController,
                    validator:
                        (value) => AppValidators.validateConfirmPassword(
                          value,
                          _passwordController.text,
                        ),
                  ),
                  SizedBox(height: 20.h),
                  PrimaryButton(
                    label: 'Register',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthRegisterEvent(
                            name:
                                _emailController.text.split(
                                  '@',
                                )[0], // Use email prefix as name
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
