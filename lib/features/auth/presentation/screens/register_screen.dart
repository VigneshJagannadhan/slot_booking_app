import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/helpers/navigation_helper.dart';
import 'package:slot_booking_app/core/themes/app_colors.dart';
import 'package:slot_booking_app/utils/snackbar_helper.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/liquid_glass_background.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/password_text_form_field.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/primary_button.dart';
import 'package:slot_booking_app/features/home/presentation/screens/home_screen.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';
import 'package:slot_booking_app/utils/app_validators.dart';

class RegisterScreen extends StatefulWidget {
  static const String route = 'register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _hospitalOrClinicController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final ValueNotifier<bool> _isInLoginMode = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isDoctor = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    _isInLoginMode.dispose();
    _isDoctor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: _isInLoginMode,
        builder: (context, isInLoginMode, _) {
          return Form(
            key: _formKey,
            child: AuthScreenBackground(
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    isInLoginMode ? 'Welcome Back' : 'Create a new account',
                    style: AppStyles.ts28CFFFFFFW600,
                  ),
                  SizedBox(height: 30.h),
                  LiquidGlassBackground(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                        if (!isInLoginMode) SizedBox(height: 20.h),
                        if (!isInLoginMode)
                          ValueListenableBuilder<bool>(
                            valueListenable: _isDoctor,
                            builder: (context, isDoctor, _) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 1.sw,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 10.h,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Are you a doctor?",
                                          style: AppStyles.ts12C000W400,
                                        ),
                                        SizedBox(width: 20.w),
                                        Switch.adaptive(
                                          value: isDoctor,
                                          onChanged: (v) {
                                            _isDoctor.value = v;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (_isDoctor.value) SizedBox(height: 20.h),
                                  if (_isDoctor.value)
                                    CustomTextFormField(
                                      labelText: 'Hospital or Clinic',
                                      hintText: '',
                                      prefixIcon: Icons.local_hospital,
                                      controller: _hospitalOrClinicController,
                                      validator:
                                          AppValidators.validateHospitalName,
                                    ),
                                ],
                              );
                            },
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
                            controller: _confirmPassController,
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
    _isInLoginMode.value = !_isInLoginMode.value;
    _formKey.currentState?.reset();
    _isDoctor.value = false;
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
              isDoctor: _isDoctor.value,
              hospital: _hospitalOrClinicController.text,
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

      NavigationHelper.pushAndReplaceNamed(
        context: context,
        destination: HomeScreen.route,
      );
    }
    if (state is AuthFailure) {
      SnackbarHelper.showSnackbar(
        context: context,
        message: state.failure.message,
        isError: true,
      );
    }
  }
}

class AuthScreenBackground extends StatelessWidget {
  const AuthScreenBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: child,
    );
  }
}
