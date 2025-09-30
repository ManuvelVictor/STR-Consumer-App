class OtpState {
  final List<String> digits;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isResending;
  final String? errorMessage;

  OtpState({
    List<String>? digits,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.isResending = false,
    this.errorMessage,
  }) : digits = digits ?? ['', '', '', ''];

  bool get isComplete => digits.every((digit) => digit.isNotEmpty);

  String get otpCode => digits.join();

  OtpState copyWith({
    List<String>? digits,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? isResending,
    String? errorMessage,
  }) {
    return OtpState(
      digits: digits ?? this.digits,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isResending: isResending ?? this.isResending,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}