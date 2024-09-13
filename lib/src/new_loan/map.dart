import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:money2me/common/config/theme.dart';
import 'package:money2me/common/widget/dialoghelper.dart';
import 'package:money2me/src/new_loan/model/map_address.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapState();
}

class _MapState extends State<MapScreen> {
  List<MapAddress> addresses = [];
  MapAddress? address;
  bool showSuggestion = false;
  bool isFirst = true;
  Position? _currentPosition;
  Set<Marker> markers = {};

  TextEditingController addressController = TextEditingController();
  LatLng markerPosition = const LatLng(37.42796133580664, -122.085749655962);
  CameraPosition? _currentCameraPosition;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  init() async {
    _currentPosition = await _determinePosition(context);
    if (_currentPosition != null) {
      _currentCameraPosition = CameraPosition(
          target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          zoom: 18);
      _goToCurrentLocation();
    }
  }

  setMarker(LatLng latLng) {
    Marker marker = Marker(
      markerId: const MarkerId('pin'),
      position: latLng,
      draggable: true,
    );
    markers.clear();
    markers.add(marker);
  }

  Future<Position> _determinePosition(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      DialogHelper.showAlert(context, '', 'Location services are disabled.',
          () {
        Navigator.pop(context);
      });
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context,address);
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: true,
              myLocationEnabled:true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (latLng) {
                setState(() {
                  showSuggestion = false;
                });
              },
              onCameraIdle: () {
                  showSuggestion = true;
                  isFirst? null: setState(() {});
                  isFirst = false;
                setPlaceMark(markerPosition);
              },
              onCameraMove: (cameraPosition) {
                setState(() {
                  showSuggestion = false;
                  markerPosition = cameraPosition.target;
                  setMarker(markerPosition);
                });
              },
              markers: markers,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                  color: kWhiteColor,
                  height: 56.h,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 56.h,
                        child: IconButton(
                          iconSize: 24.sp,
                          icon: Icon(
                            Icons.arrow_back,
                            color: kBlackColor,
                            size: 24.sp,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 8).r,
                        width: MediaQuery.sizeOf(context).width - 56.h,
                        child: TextFormField(
                          controller: addressController,
                          decoration: const InputDecoration(
                            hintText: "Address",
                          ),
                          readOnly: true,
                        ),
                      )
                    ],
                  )),
            ),
           if(showSuggestion)...[Positioned(right: 8, top: 56.h, child: suggestionWidget())],
          ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: kPrimaryColor,
          onPressed: (){
            Navigator.pop(context,address);
          },
          label: Text("Select Location",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: kWhiteColor),),
        ),
      ),
    );
  }

  Widget suggestionWidget() {
    return Container(
      color: kWhiteColor,
      height: MediaQuery.sizeOf(context).height * 0.20,
      width: MediaQuery.sizeOf(context).width - 56.h,
      child: ListView.builder(
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                addressController.text = addresses[index].address;
                address = addresses[index];
                setState(() {
                  showSuggestion = false;
                });
              },
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: kBlackColor, width: 0.5))),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12).r,
                child: Text(
                  addresses[index].address,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: kBlackColor),
                ),
              ),
            );
          }),
    );
  }

  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
        CameraUpdate.newCameraPosition(_currentCameraPosition ?? _kGooglePlex));
    setMarker(_currentCameraPosition?.target ?? _kGooglePlex.target);
  }

  setPlaceMark(LatLng latLng) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    addresses = List.generate(placeMarks.length, (index){
      Placemark placeMark = placeMarks[index];
      String address = placeMarkToText(placeMark);
      return MapAddress(address,placeMark);
    });
    address = addresses.first;
    addressController.text = addresses.first.address;
  }

  placeMarkToText(Placemark placemark){
    return addressFields(placemark.street)+addressFields(placemark.locality)+addressFields(placemark.subLocality)+addressFields(placemark.subAdministrativeArea)+addressFields(placemark.administrativeArea)+addressFields(placemark.postalCode,isLast: true);
  }

  String addressFields(String? value,{bool? isLast}){
    return (value??"").isEmpty ? "":"$value${isLast==null || !isLast?", ":""}";
  }
}
