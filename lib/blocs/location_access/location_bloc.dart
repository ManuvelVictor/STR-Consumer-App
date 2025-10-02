import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationState()) {
    on<EnableLocationRequested>(_onEnableLocation);
    on<SkipLocationRequested>(_onSkipLocation);
    on<CheckLocationPermission>(_onCheckPermission);
    on<CompleteLocationGranted>(_onCompleteLocationGranted);
  }

  Future<void> _onEnableLocation(
      EnableLocationRequested event,
      Emitter<LocationState> emit,
      ) async {
    emit(const LocationState(isLoading: true));

    try {
      final status = await Permission.location.request();

      if (status.isDenied) {
        emit(
          const LocationState(
            isLoading: false,
            isPermissionDenied: true,
            errorMessage: "Location permission denied",
          ),
        );
        return;
      }

      if (status.isPermanentlyDenied) {
        emit(
          const LocationState(
            isLoading: false,
            isPermissionDenied: true,
            errorMessage:
            "Location permission permanently denied. Please enable in settings.",
          ),
        );
        return;
      }

      if (status.isGranted) {
        emit(const LocationState(
          isLoading: false,
          justGrantedNow: true,
          isSuccess: false,
          shouldNavigate: false,
        ));

        await Future.delayed(const Duration(seconds: 2));

        add(CompleteLocationGranted());
      }
    } catch (e) {
      emit(
        LocationState(
          isLoading: false,
          isFailure: true,
          errorMessage: "Failed to enable location: $e",
        ),
      );
    }
  }

  void _onCompleteLocationGranted(
      CompleteLocationGranted event,
      Emitter<LocationState> emit,
      ) {
    emit(const LocationState(
      isSuccess: true,
      justGrantedNow: false,
      shouldNavigate: true,
    ));
  }

  Future<void> _onSkipLocation(
      SkipLocationRequested event,
      Emitter<LocationState> emit,
      ) async {
    emit(const LocationState(
      isSuccess: true,
      justGrantedNow: false,
      shouldNavigate: true,
    ));
  }

  Future<void> _onCheckPermission(
      CheckLocationPermission event,
      Emitter<LocationState> emit,
      ) async {
    try {
      final status = await Permission.location.status;

      if (status.isGranted) {
        emit(const LocationState(
          isSuccess: true,
          justGrantedNow: false,
          shouldNavigate: true,
        ));
      }
    } catch (e) {
      // Let UI stay on location access screen
    }
  }
}