import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/login_screen.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/password_text_form_field.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/primary_button.dart';
import 'package:slot_booking_app/features/home/presentation/screens/home_screen.dart';
import 'package:slot_booking_app/core/utils/app_styles.dart';
import 'package:slot_booking_app/core/utils/app_validators.dart';
import 'package:slot_booking_app/core/utils/snackbar_helper.dart';

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
      body: Form(
        key: _formKey,
        child: Container(
          height: 1.sh,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Register', style: AppStyles.ts24C000W600),
              ),
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
              PasswordTextFormField(
                labelText: 'Password',
                hintText: 'Enter your password',
                controller: _passwordController,
                validator: AppValidators.validatePassword,
              ),
              SizedBox(height: 20.h),
              PasswordTextFormField(
                labelText: 'Confirm Password',
                hintText: 'Enter your confirm password',
                controller: _confirmPasswordController,
                validator:
                    (value) => AppValidators.validateConfirmPassword(
                      value,
                      _passwordController.text,
                    ),
              ),
              SizedBox(height: 20.h),
              BlocConsumer<AuthBloc, AuthState>(
                listener: _listenToAuthChanges,
                builder: (context, state) {
                  return PrimaryButton(
                    isLoading: state is AuthLoading,
                    label: 'Register',
                    onPressed: () => _onRegisterButtonPressed(context),
                  );
                },
              ),
              SizedBox(height: 20.h),
              TextButton(
                onPressed: () => _onCreateAccountButtonPressed(context),
                child: Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCreateAccountButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _onRegisterButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        RegisterRequested(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  void _listenToAuthChanges(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      SnackbarHelper.showSnackbar(
        context: context,
        message: 'Register successful',
      );
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
