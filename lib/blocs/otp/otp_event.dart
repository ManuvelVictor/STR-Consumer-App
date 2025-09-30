abstract class OtpEvent {}

class OtpDigitChanged extends OtpEvent {
  final int index;
  final String digit;

  OtpDigitChanged(this.index, this.digit);
}

class OtpSubmitted extends OtpEvent {}

class ResendOtpRequested extends OtpEvent {}