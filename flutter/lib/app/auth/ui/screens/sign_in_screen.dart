import 'package:blockin/app/auth/ui/screens/forgot_password_screen.dart';
import 'package:blockin/app/auth/ui/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blockin/app/auth/ui/blocs/sign_in/sign_in_bloc.dart';
import 'package:blockin/app/auth/ui/components/templates/sign_in_template.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';
import 'package:blockin/app/shared/ui/components/molecules/snackbar_service.dart';
import 'package:blockin/core/app_injections.dart';
import 'package:blockin/core/navigation/routes.dart';
import 'package:blockin/app/board/ui/screens/home_screen.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/sign-in';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final signInBloc = getIt.get<SignInBloc>();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => signInBloc,
      child: BlocListener<SignInBloc, SignInState>(
        listener: _signInListener,
        child: SignInTemplate(
          formKey: formKey,
          emailController: emailController,
          passwordController: passwordController,
          onForgotPasswordPressed: _onForgotPasswordPressed,
          onSignUpPressed: _onSignUpPressed,
          onGoogleSignInPressed: _onGoogleSignInPressed,
          onAppleSignInPressed: _onAppleSignInPressed,
          onSignInPressed: _onSignInPressed,
        ),
      ),
    );
  }

  void _signInListener(BuildContext context, SignInState state) {
    if (state.userResult is Success) {
      router.go(TetrisDemoScreen.routeName);
    }

    if (state.userResult is Error) {
      SnackbarService.of(
        context,
      ).error((state.userResult as Error).getMessage(context));
    }
  }

  void _onForgotPasswordPressed() {
    router.push(ForgotPasswordScreen.routeName);
  }

  void _onSignUpPressed() {
    router.push(SignUpScreen.routeName);
  }

  void _onGoogleSignInPressed() {
    signInBloc.add(SignInWithGoogleEvent());
  }

  void _onAppleSignInPressed() {
    signInBloc.add(SignInWithAppleEvent());
  }

  void _onSignInPressed() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      signInBloc.add(
        SignInWithEmailEvent(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    }
  }
}
