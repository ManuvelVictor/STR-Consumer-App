import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<PhoneChanged>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(
        state.copyWith(isSubmitting: true, isSuccess: false, isFailure: false),
      );
      await Future.delayed(const Duration(seconds: 2));
      if (state.phone.isNotEmpty) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
        emit(state.copyWith(isSuccess: false));
      } else {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
        emit(state.copyWith(isFailure: false));
      }
    });
  }
}
