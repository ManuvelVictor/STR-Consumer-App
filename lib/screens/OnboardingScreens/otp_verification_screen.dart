import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../blocs/otp/otp_bloc.dart';
import '../../../blocs/otp/otp_event.dart';
import '../../../blocs/otp/otp_state.dart';
import '../../../nav/routes.dart';
import '../../../widgets/Auth/auth_background.dart';
import '../../../widgets/Auth/auth_button.dart';
import '../../../widgets/Auth/auth_header.dart';
import '../../utils/app_colors.dart';
import '../../widgets/Onboarding/otp_input_field.dart';
import '../../widgets/Onboarding/resend_otp_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(4, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value, BuildContext context) {
    context.read<OtpBloc>().add(OtpDigitChanged(index, value));

    setState(() {});

    if (value.isNotEmpty && index < 3) {
      if (_controllers[index + 1].text.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _focusNodes[index + 1].requestFocus();
        });
      }
    } else if (value.isEmpty && index > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNodes[index - 1].requestFocus();
      });
    }
  }

  String _maskPhoneNumber(String phone) {
    if (phone.length <= 3) return phone;
    final visible = phone.substring(phone.length - 3);
    final masked = '*' * (phone.length - 3);
    return '$masked$visible';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => OtpBloc(widget.phoneNumber),
        child: BlocConsumer<OtpBloc, OtpState>(
          listener: (context, state) {
            if (state.isSuccess) {
              context.go(AppRoutes.locationAccess);
            }
            if (state.isFailure && state.errorMessage != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          builder: (context, state) {
            return AuthBackground(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 48,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: AppColors.textSecondary,
                                ),
                                onPressed: () => context.pop(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        AuthHeader(
                          title: "— Login —",
                          subtitle: "Enter OTP to Log In",
                          description:
                              "We sent a 4-digit code to your phone (+91 ${_maskPhoneNumber(widget.phoneNumber)}). Enter it below to continue",
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            4,
                            (index) => OtpInputField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              onChanged: (value) =>
                                  _onDigitChanged(index, value, context),
                              enabled:
                                  index == 0 ||
                                  _controllers[index - 1].text.isNotEmpty,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        AuthButton(
                          label: "Verify & Continue",
                          isLoading: state.isSubmitting,
                          onPressed: () =>
                              context.read<OtpBloc>().add(OtpSubmitted()),
                        ),
                        const SizedBox(height: 20),
                        ResendOtpButton(
                          isLoading: state.isResending,
                          onPressed: () =>
                              context.read<OtpBloc>().add(ResendOtpRequested()),
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
