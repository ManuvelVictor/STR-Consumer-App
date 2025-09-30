import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../blocs/signup/signup_bloc.dart';
import '../../../blocs/signup/signup_event.dart';
import '../../../blocs/signup/signup_state.dart';
import '../../../nav/routes.dart';
import '../../../widgets/Auth/auth_background.dart';
import '../../../widgets/Auth/auth_bottom_text.dart';
import '../../../widgets/Auth/auth_button.dart';
import '../../../widgets/Auth/auth_header.dart';
import '../../../widgets/Auth/auth_logo.dart';
import '../../../widgets/Auth/auth_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SignUpBloc(),
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Sign Up Successful!")),
              );
            }
            if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please fill all required fields"),
                ),
              );
            }
          },
          builder: (context, state) {
            return AuthBackground(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        const AuthLogo(),
                        const SizedBox(height: 20),
                        const AuthHeader(
                          title: "— Sign Up —",
                          subtitle: "Get Started with Delicious Meals!",
                          description:
                              "Create your account to explore daily orders,\nweekly plans, and catering options",
                        ),
                        const SizedBox(height: 30),
                        AuthTextField(
                          hint: "Enter your name",
                          onChanged: (value) => context.read<SignUpBloc>().add(
                            NameChanged(value),
                          ),
                        ),
                        const SizedBox(height: 16),
                        AuthTextField(
                          hint: "Phone number",
                          inputType: TextInputType.phone,
                          prefix: "+91",
                          onChanged: (value) => context.read<SignUpBloc>().add(
                            PhoneChanged(value),
                          ),
                        ),
                        const SizedBox(height: 16),
                        AuthTextField(
                          hint: "Mail ID (Optional)",
                          onChanged: (value) => context.read<SignUpBloc>().add(
                            EmailChanged(value),
                          ),
                        ),
                        const SizedBox(height: 30),
                        AuthButton(
                          label: "Sign Up",
                          isLoading: state.isSubmitting,
                          onPressed: state.isSubmitting
                              ? null
                              : () => context.read<SignUpBloc>().add(
                                  SignUpSubmitted(),
                                ),
                        ),
                        const SizedBox(height: 20),
                        AuthBottomText(
                          text: "Already have an account? ",
                          actionText: "Login",
                          onTap: () => context.go(AppRoutes.login),
                        ),
                        const SizedBox(height: 40),
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
