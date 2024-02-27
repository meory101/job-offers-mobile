import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kml/components/rectangular_button.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

class showMap extends StatefulWidget {
  String? lat;
  String? long;
  showMap({required this.lat, required this.long});
  @override
  State<showMap> createState() => _showMapState();
}

class _showMapState extends State<showMap> {
  double? lat;
  double? long;
  @override
  void initState() {
    if (widget.lat != null) {
      lat = double.parse(widget.lat!);
      long = double.parse(widget.long!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.lat != null
            ? Stack(
                children: [
                  GoogleMap(
                    markers: {
                      Marker(
                          markerId: MarkerId("1"), position: LatLng(lat!, long!)),
                    },
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(lat!, long!),
                      zoom: 10.4746,
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
