abstract class LocationEvent {}

class EnableLocationRequested extends LocationEvent {}

class SkipLocationRequested extends LocationEvent {}

class CheckLocationPermission extends LocationEvent {}
