import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/ToastMessageCustom.dart';

class LocationService {
  /// Request permission for device location
  Future<bool> requestPermission() async {
    // Test if location services are enabled.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      ToastMessageCustom.ToastMessage(
          "Please Activate Your Location", primaryColor,textColor: Colors.white);

      return serviceEnabled;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // Logger.error(error: 'Location permissions are denied');
        Get.to(LocationPermissionView());
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // Get.toNamed(Routes.locationError);
      return false;
    }

    return true;
  }
}

class LocationPermissionView extends StatelessWidget {
  const LocationPermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      "asset/Image/backwo.png",
                      width: 34,
                      height: 34,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Location Access",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'PoppinsBoldSemi',
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image.asset(
                    "asset/Image/backwo.png",
                    width: 34,
                    height: 34,
                    color: Colors.transparent,
                  ),
                ],
              ),
              SvgPicture.asset('asset/Icon/maps.svg'),
              SizedBox(
                height: 32,
              ),
              Text(
                'The app cannot function properly without location services enabled. To activate location permissions, please press the button below.',
                style: TextStyle(fontFamily: 'PoppinsBoldSemi', fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
