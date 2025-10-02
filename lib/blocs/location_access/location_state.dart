class LocationState {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final bool isPermissionDenied;
  final bool justGrantedNow;
  final bool shouldNavigate;
  final String? errorMessage;

  const LocationState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.isPermissionDenied = false,
    this.justGrantedNow = false,
    this.shouldNavigate = false,
    this.errorMessage,
  });

  LocationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    bool? isPermissionDenied,
    bool? justGrantedNow,
    bool? shouldNavigate,
    String? errorMessage,
  }) {
    return LocationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isPermissionDenied: isPermissionDenied ?? this.isPermissionDenied,
      justGrantedNow: justGrantedNow ?? this.justGrantedNow,
      shouldNavigate: shouldNavigate ?? this.shouldNavigate,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}