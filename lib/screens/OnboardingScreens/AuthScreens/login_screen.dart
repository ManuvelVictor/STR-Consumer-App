import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../blocs/login/login_bloc.dart';
import '../../../blocs/login/login_event.dart';
import '../../../blocs/login/login_state.dart';
import '../../../nav/routes.dart';
import '../../../widgets/Auth/auth_background.dart';
import '../../../widgets/Auth/auth_bottom_text.dart';
import '../../../widgets/Auth/auth_button.dart';
import '../../../widgets/Auth/auth_header.dart';
import '../../../widgets/Auth/auth_logo.dart';
import '../../../widgets/Auth/auth_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => LoginBloc(),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              context.push(AppRoutes.otp, extra: state.phone);
            }
            if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please enter phone number")),
              );
            }
          },
          builder: (context, state) {
            return AuthBackground(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        const AuthLogo(),
                        const SizedBox(height: 20),
                        const AuthHeader(
                          title: "— Login —",
                          subtitle: "Welcome Back!",
                          description:
                              "Log in to continue enjoying your favorite meals.",
                        ),
                        const SizedBox(height: 30),
                        AuthTextField(
                          hint: "Phone number",
                          inputType: TextInputType.phone,
                          prefix: "+91",
                          onChanged: (value) => context.read<LoginBloc>().add(
                            PhoneChanged(value),
                          ),
                        ),
                        const SizedBox(height: 30),
                        AuthButton(
                          label: "Login",
                          isLoading: state.isSubmitting,
                          onPressed: () =>
                              context.read<LoginBloc>().add(LoginSubmitted()),
                        ),
                        const SizedBox(height: 20),
                        AuthBottomText(
                          text: "New here? ",
                          actionText: "Sign Up",
                          onTap: () => context.go(AppRoutes.signUp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
