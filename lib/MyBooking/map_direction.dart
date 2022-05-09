import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skep_home_pro/MapUtils/map_utils.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Back_ground_check/back_ground_check.dart';
import '../chatPage/chat.dart';
import '../controllers/complete_request_controller.dart';

class MapDirections extends StatefulWidget {
  const MapDirections({Key? key}) : super(key: key);

  @override
  State<MapDirections> createState() => _MapDirectionsState();
}

class _MapDirectionsState extends State<MapDirections> {

 // LatLng ? currentLocation ;
  LatLng ? desteinationLocation ;
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polyLineCoordinates = [];
  PolylinePoints ? polylinePoints;

  Set<Marker> _markers = {};
  var currentLocation;

  @override
  void initState() {
    // TODO: implement initState
    polylinePoints = PolylinePoints();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<CompleteRequestController>(
      init: CompleteRequestController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                icon: Image.asset("assets/images/ring.png"),
                onPressed: () {
                  // do something
                },
              )
            ],
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Center(
              child: Text(
                "Track Request",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                tiltGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                polylines: _polylines,
                markers: _markers,
                initialCameraPosition: CameraPosition(
                    target: LatLng(controller.lat,
                        controller.log),
                    zoom: 15),
                onMapCreated: (controllerG) async{
                  setState(() {
                    _markers.add(
                        Marker(markerId: MarkerId("id-1") , position: LatLng(controller.lat , controller.log))
                    );
                  });



                    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                    var lastPosition = await Geolocator.getLastKnownPosition();
                    var lat = position.latitude;
                    var lng = position.longitude;
                    print("$lat       $lng");

                    setState(() {
                      currentLocation = "$position";
                    });

                  print("QQQQQQQQ $lat RRRRRRRR $lng");


                  PolylineResult? result = await polylinePoints?.getRouteBetweenCoordinates(constants.googleMapApi,
                    PointLatLng(lat, lng),
                    PointLatLng(controller.lat, controller.log),
                    travelMode: TravelMode.driving,
                    // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
                  );

                  if(result!.status == 'OK'){
                    result.points.forEach((PointLatLng point) {
                      polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
                    });

                    setState(() {
                      _polylines.add(
                          Polyline(
                              width: 10,
                              polylineId: PolylineId('polyLine'),
                              color: Color(0xFF08A5CB),
                              points: polyLineCoordinates
                          )
                      );
                    });
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white , 
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 55.0,
                              height: 55.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.green,
                                backgroundImage: NetworkImage(
                                    controller.requestDetailsModel!.serviceRequest.image == "" ?
                                    "https://www.kindpng.com/picc/m/207-2074624_white-gray-circle-avatar-png-transparent-png.png"  :
                                    "https://staging.skephome.com/storage/${controller.requestDetailsModel!.serviceRequest.image}"),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  backgroundColor: constants.yellow,
                                  child: IconButton(
                                      onPressed: () {
                                        launch(
                                            "tel://${controller.requestDetailsModel!.serviceRequest.homeownerPhone}");
                                      },
                                      icon: Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  backgroundColor: constants.blue2,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => chatpage(email: "$EmailUser")),);
                                    },
                                    icon: Icon(Icons.chat,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          controller.requestDetailsModel!
                              .serviceRequest.fullName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Ubuntu',
                              fontWeight:
                              FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          controller.requestDetailsModel!
                              .serviceRequest.placeAddress,
                          style: TextStyle(
                              color: Colors.grey  ,
                              fontSize: 12,
                              fontFamily: 'Ubuntu',
                              fontWeight:
                              FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0 , top: 3.0),
                        child: Text(
                          controller.requestDetailsModel!
                              .serviceRequest.readableDate,
                          style: TextStyle(
                              color: constants.yellow  ,
                              fontSize: 12,
                              fontFamily: 'Ubuntu',
                              fontWeight:
                              FontWeight.bold),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(onPressed: (){
                      MapUtils.openMap(controller.lat, controller.log);
                    } , child: Image.asset('assets/images/map-2.png'), backgroundColor: Colors.white,)),
              )
            ],
          ),
        );
      },
    ));
  }
}
