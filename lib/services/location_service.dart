import '../models/Home/location_model.dart';

class LocationService {
  Future<LocationModel> getCurrentLocation() async {
    await Future.delayed(Duration(milliseconds: 300));
    return LocationModel(
      address: '34-1 ASR colony 1st street, dindigul-624619',
      label: 'Home',
      latitude: 10.3623,
      longitude: 77.9694,
    );
  }
}