import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<PhoneChanged>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<SignUpSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));

      await Future.delayed(const Duration(seconds: 2));

      if (state.phone.isNotEmpty && state.name.isNotEmpty) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }
}
