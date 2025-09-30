import 'package:flutter_bloc/flutter_bloc.dart';

import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState()) {
    on<EnableLocationRequested>(_onEnableLocation);
    on<SkipLocationRequested>(_onSkipLocation);
    on<CheckLocationPermission>(_onCheckPermission);
  }

  Future<void> _onEnableLocation(
    EnableLocationRequested event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      // TODO: Request location_access permission
      // import 'package:geolocator/geolocator.dart';
      // LocationPermission permission = await Geolocator.requestPermission();

      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      // if (permission == LocationPermission.denied) {
      //   emit(state.copyWith(
      //     isLoading: false,
      //     isPermissionDenied: true,
      //     errorMessage: "Location permission denied",
      //   ));
      //   return;
      // }

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isFailure: true,
          errorMessage: "Failed to enable location_access",
        ),
      );
    }
  }

  Future<void> _onSkipLocation(
    SkipLocationRequested event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(isSuccess: true));
  }

  Future<void> _onCheckPermission(
    CheckLocationPermission event,
    Emitter<LocationState> emit,
  ) async {
    try {
      // TODO: Check if location_access permission is already granted
      // import 'package:geolocator/geolocator.dart';
      // LocationPermission permission = await Geolocator.checkPermission();
      // if (permission == LocationPermission.always ||
      //     permission == LocationPermission.whileInUse) {
      //   emit(state.copyWith(isSuccess: true));
      // }
    } catch (e) {
      // Continue to show location_access screen
    }
  }
}
