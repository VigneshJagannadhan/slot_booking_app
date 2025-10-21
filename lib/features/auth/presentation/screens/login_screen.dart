import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/features/auth/bloc/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/primary_button.dart';
import 'package:slot_booking_app/features/home/presentation/screens/home_screen.dart';
import 'package:slot_booking_app/utils/app_styles.dart';
import 'package:slot_booking_app/utils/app_validators.dart';
import 'package:slot_booking_app/utils/snackbar_helper.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
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
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    SnackbarHelper.registrationSuccess(context);
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
                  if (state is AuthError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (context.mounted) {
                        SnackbarHelper.error(context, message: state.error);
                      }
                    });
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    isLoading: state is AuthLoading,
                    label: 'Register',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthRegisterEvent(
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
