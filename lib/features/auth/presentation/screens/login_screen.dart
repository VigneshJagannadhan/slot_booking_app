import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/features/auth/bloc/auth/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/register_screen.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/password_text_form_field.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/primary_button.dart';
import 'package:slot_booking_app/features/home/presentation/screens/home_screen.dart';
import 'package:slot_booking_app/utils/app_styles.dart';
import 'package:slot_booking_app/utils/app_validators.dart';
import 'package:slot_booking_app/utils/snackbar_helper.dart';

class LoginScreen extends StatelessWidget {
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
          height: 1.sh,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Login', style: AppStyles.ts24C000W600),
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
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  void _onLoginButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthLoginEvent(
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
        message: 'Login successful',
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
    if (state is AuthError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          SnackbarHelper.showSnackbar(
            context: context,
            message: state.error,
            isError: true,
          );
        }
      });
    }
  }
}
