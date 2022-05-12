import 'package:flutter/cupertino.dart';
import 'package:users_app/models/directions.dart';

class AppInfo extends ChangeNotifier {
  Directions? userPickUpLocation, userDropOffLocation;

  void updatePickupLocationAddress(Directions userPickupAddress) {
    userPickUpLocation = userPickupAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Directions dropOffAddress) {
    userDropOffLocation = dropOffAddress;
    notifyListeners();
  }
}
