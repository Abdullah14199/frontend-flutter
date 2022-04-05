import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/models/my_booking_model.dart';

class RequestsDetails extends StatefulWidget {
  final ScheduleBooking myBookingModel;

  const RequestsDetails({Key? key, required this.myBookingModel})
      : super(key: key);

  @override
  State<RequestsDetails> createState() => _RequestsDetailsState();
}

class _RequestsDetailsState extends State<RequestsDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
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
            "Requests Details",
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
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              width: double.infinity,
              height: 200,
              child: GoogleMap(
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                zoomGesturesEnabled: false,
                tiltGesturesEnabled: false,
                rotateGesturesEnabled: false,
                initialCameraPosition: const CameraPosition(
                    target: LatLng(43.68471379096746, -79.50960394822533),
                    zoom: 9.5),
                onMapCreated: (GoogleMapController controller) {},
              ),
            ),
          ),
          Positioned(
              top: 280,
              left: 270,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Ink(
                      decoration: const ShapeDecoration(
                        color: constants.yellow,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.phone , color: Colors.white, ))),
                  Ink(
                      decoration: const ShapeDecoration(
                        color: constants.blue,
                        shape: CircleBorder(),
                      ),
                      child:
                          IconButton(onPressed: () {}, icon: Icon(Icons.chat , color: Colors.white))),
                ],
              ))
        ],
      ),
    ));
  }
}
