import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String name;
  final String phone;
  final String email;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const SignUpState({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  SignUpState copyWith({
    String? name,
    String? phone,
    String? email,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return SignUpState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object?> get props =>
      [name, phone, email, isSubmitting, isSuccess, isFailure];
}
