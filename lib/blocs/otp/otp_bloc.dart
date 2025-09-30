import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final String phoneNumber;

  OtpBloc(this.phoneNumber) : super(OtpState()) {
    on<OtpDigitChanged>(_onDigitChanged);
    on<OtpSubmitted>(_onSubmitted);
    on<ResendOtpRequested>(_onResendOtp);
  }

  void _onDigitChanged(OtpDigitChanged event, Emitter<OtpState> emit) {
    final newDigits = List<String>.from(state.digits);
    newDigits[event.index] = event.digit;
    emit(state.copyWith(
      digits: newDigits,
      isFailure: false,
      errorMessage: null,
    ));
  }

  Future<void> _onSubmitted(OtpSubmitted event, Emitter<OtpState> emit) async {
    if (!state.isComplete) {
      emit(state.copyWith(
        isFailure: true,
        errorMessage: "Please enter complete OTP",
      ));
      return;
    }

    emit(state.copyWith(isSubmitting: true, isFailure: false, errorMessage: null));

    final otpCode = state.digits.join();

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (otpCode == "1616") {
        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: true,
        ));
      } else {
        emit(state.copyWith(
          isSubmitting: false,
          isFailure: true,
          errorMessage: "Invalid OTP. Please try again.",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        isFailure: true,
        errorMessage: "Something went wrong. Please try again.",
      ));
    }
  }


  Future<void> _onResendOtp(
      ResendOtpRequested event, Emitter<OtpState> emit) async {
    emit(state.copyWith(isResending: true));

    try {
      await Future.delayed(const Duration(seconds: 1));

      // await _authRepository.resendOtp(phoneNumber);

      emit(state.copyWith(
        isResending: false,
        digits: ['', '', '', ''],
      ));
    } catch (e) {
      emit(state.copyWith(
        isResending: false,
        isFailure: true,
        errorMessage: "Failed to resend OTP",
      ));
    }
  }
}