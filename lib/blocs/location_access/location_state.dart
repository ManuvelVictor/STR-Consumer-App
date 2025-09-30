class LocationState {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final bool isPermissionDenied;
  final String? errorMessage;

  LocationState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.isPermissionDenied = false,
    this.errorMessage,
  });

  LocationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    bool? isPermissionDenied,
    String? errorMessage,
  }) {
    return LocationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isPermissionDenied: isPermissionDenied ?? this.isPermissionDenied,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
