import 'package:blockin/app/auth/ui/screens/check_email_screen.dart';
import 'package:blockin/app/auth/ui/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blockin/app/auth/domain/dto/sign_up_dto.dart';
import 'package:blockin/app/auth/ui/blocs/sign_up/sign_up_bloc.dart';
import 'package:blockin/app/auth/ui/components/templates/sign_up_template.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';
import 'package:blockin/app/shared/ui/components/molecules/snackbar_service.dart';
import 'package:blockin/core/app_injections.dart';
import 'package:blockin/core/navigation/routes.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpBloc = getIt.get<SignUpBloc>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => signUpBloc,
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: _signUpListener,
        child: SignUpTemplate(
          formKey: formKey,
          nameController: nameController,
          emailController: emailController,
          passwordController: passwordController,
          onSignInPressed: _onSignInPressed,
          onGoogleSignUpPressed: _onGoogleSignUpPressed,
          onAppleSignUpPressed: _onAppleSignUpPressed,
          onSignUpPressed: _onSignUpPressed,
        ),
      ),
    );
  }

  void _signUpListener(BuildContext context, SignUpState state) {
    if (state.userResult is Success) {
      router.pushReplacement(
        '${CheckEmailScreen.routeName}?email=${Uri.encodeComponent(emailController.text)}',
      );
    }
    if (state.userResult is Error) {
      SnackbarService.of(
        context,
      ).error((state.userResult as Error).getMessage(context));
    }
  }

  void _onSignInPressed() {
    router.go(SignInScreen.routeName);
  }

  void _onGoogleSignUpPressed() {
    signUpBloc.add(SignUpWithGoogleEvent());
  }

  void _onAppleSignUpPressed() {
    signUpBloc.add(SignUpWithAppleEvent());
  }

  void _onSignUpPressed() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      signUpBloc.add(
        SignUpWithEmailEvent(
          signUpDto: SignUpDto(
            fullName: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          ),
        ),
      );
    }
  }
}
