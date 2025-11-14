import 'package:blockin/app/auth/ui/screens/check_email_screen.dart';
import 'package:blockin/app/auth/ui/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blockin/app/auth/domain/dto/sign_up_dto.dart';
import 'package:blockin/app/auth/ui/blocs/sign_up/sign_up_bloc.dart';
import 'package:blockin/app/auth/ui/blocs/sign_in/sign_in_bloc.dart';
import 'package:blockin/app/auth/ui/components/templates/sign_up_template.dart';
import 'package:blockin/app/shared/domain/dto/result.dart';
import 'package:blockin/app/shared/ui/components/molecules/snackbar_service.dart';
import 'package:blockin/core/app_injections.dart';
import 'package:blockin/core/navigation/routes.dart';
import 'package:blockin/app/board/ui/screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpBloc = getIt.get<SignUpBloc>();
  final signInBloc = getIt.get<SignInBloc>();

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
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: signUpBloc),
        BlocProvider.value(value: signInBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SignUpBloc, SignUpState>(listener: _signUpListener),
          BlocListener<SignInBloc, SignInState>(listener: _signInListener),
        ],
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

  void _onSignInPressed() {
    router.pushReplacement(SignInScreen.routeName);
  }

  void _onGoogleSignUpPressed() {
    signInBloc.add(SignInWithGoogleEvent());
  }

  void _onAppleSignUpPressed() {
    signInBloc.add(SignInWithAppleEvent());
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
