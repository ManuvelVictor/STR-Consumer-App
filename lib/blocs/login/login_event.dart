import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PhoneChanged extends LoginEvent {
  final String phone;
  PhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class LoginSubmitted extends LoginEvent {}
