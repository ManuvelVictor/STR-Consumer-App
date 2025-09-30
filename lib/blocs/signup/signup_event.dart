import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NameChanged extends SignUpEvent {
  final String name;
  NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class PhoneChanged extends SignUpEvent {
  final String phone;
  PhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class EmailChanged extends SignUpEvent {
  final String email;
  EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class SignUpSubmitted extends SignUpEvent {}
