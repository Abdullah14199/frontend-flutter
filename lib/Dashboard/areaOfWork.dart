import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:http/http.dart' as http;
import 'package:skep_home_pro/models/allCitiesModel.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';


class AreaOfWork extends StatefulWidget {
  const AreaOfWork({Key? key}) : super(key: key);

  @override
  State<AreaOfWork> createState() => _AreaOfWorkState();
}

class _AreaOfWorkState extends State<AreaOfWork> {

  final Completer<GoogleMapController> _controller = Completer();


  // AreaOfWork/AllCitys
  Future<List<AllCitys>> fetchPosts() async {
    final response =await http
        .get(Uri.parse('https://staging.skephome.com/api/AreaOfWork/AllCitys'),
        headers: {
          HttpHeaders.authorizationHeader : 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1MSIsImp0aSI6ImUxM2YzYmVjZWFjMzc0NDcwZTA2ODNkZDVmYWZmOWJkYzkzMmZmZWE3MjY2YmE1NDI5MDUwMDM0NzRlM2JhOWNmNGM3ZGM2NzIzZDZjNjFhIiwiaWF0IjoxNjQ3MzQ4NDQ4LCJuYmYiOjE2NDczNDg0NDgsImV4cCI6MTY3ODg4NDQ0OCwic3ViIjoiNTYiLCJzY29wZXMiOltdfQ.oUr1WS1-YuWrF9VdPOsJmRMCRxZVtULJSpVRDC_cM7CjpkIztzEB2mQCt9EMvWTwj_cr6r-UYiU-S4dnOS-GaK6FV2KInbM-23Nv-tOYj8Th19_qwpRgzEJWlukv2R-05vA7FDegRJ0L4jEtfycBSDqNd6KEXaULqiYvjHuCaO0nRnyp1_QWU-5Uan0Od7vdPQ6uYLd_ecP1oYtoF1gnzPq7dkbaVHkGwDCd8NIyVBvnDxr3PLkjU6RhazptZD7zDu65-ItIlEr_0NHVqOh78MpHRoPFag531OYQIPMj8NjNdw8SRdpZnr2Rxt-XdV1pfJrzvfsZZ1oG2ydyrwnkTQqiqwPYyxsT6UlElvlXMwA9XCpzzro16W1V66paDgrv5Fp0-Ev1IngnlZhfEduEkVUA2hWd68q-a0yl6j_8s48Mcc3_nFf-HD2cyIpbkNVPJww8YJ18mxR0s-fwGdke6wq2yPCnTwqLZcjSjb_jED6IMNgY_tSUX9v5Bq1dGYm5IxtQ039suJj53YpTikSawj8-UPrj3rPjnvaHpdvChsb3Ln2zaBJXew5QEgJBX7KlRIUTn2hIXL5lEkJbfB5TbZNzK5bw5sfNQLbU4yI2nWtpMTBfscCIMB-sp9x9JM1MQQw_dLNwiJA2jCTXzFjKeExG3G8mp8OmbEEO8vrcz6Q'
        }
    );
    var responseJson = json.decode(response.body);
    return (responseJson['AllCitys'] as List)
        .map((p) => AllCitys.fromJson(p))
        .toList();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                icon:  Image.asset("assets/images/ring.png"),
                onPressed: () {
                  // do something
                },
              )
            ],
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Padding(
              padding: EdgeInsets.only(left: 90),
              child: Text("Area of work" , style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu',
              ),),
            ),
          ),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15 , top: 15),
                    child: Text("Province" , style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 14 ,
                      fontWeight: FontWeight.normal,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: "Ontario",
                      decoration:  InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:  const BorderSide(width: 3, color: constants.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:  const BorderSide(width: 2,color: constants.grey),
                              borderRadius: BorderRadius.circular(15)
                          ),
                      ),
                      readOnly: true,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15 , top: 15),
                    child: Text("City" , style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 14 ,
                      fontWeight: FontWeight.normal,
                    ),),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15 , top: 8),
                    child: Text("You can select more than one area" , style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 14 ,
                      fontWeight: FontWeight.normal,
                      color: constants.grey,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration:  InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            _modalBottomSheetMenu(context);
                          },
                          icon: Icon(Icons.keyboard_arrow_down),
                        ),
                        fillColor: constants.grey,
                        labelText: "Multiple Area Selection",
                        enabledBorder: OutlineInputBorder(
                          borderSide:  const BorderSide(width: 3, color: constants.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:  const BorderSide(width: 2,color: constants.grey),
                            borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15 , right: 15 , top: 20 , bottom: 20),
                      child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child:GoogleMap(
                            mapType: MapType.normal,
                            zoomControlsEnabled: false,
                            initialCameraPosition: const CameraPosition(target: LatLng(43.67105955861069 , -79.54859201085549) , zoom: 8 ),
                            onMapCreated: (GoogleMapController controller){
                                _controller.complete(controller);
                            },
                          ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0 , right: 15.0 , bottom: 8),
                    child: GestureDetector(
                      onTap: (){

                      },
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: constants.blue2,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: const Center(
                            child: Text("Save Changes" ,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ubuntu' ,
                              ),),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
    ));
  }

  bool Etobicoke = false;
  bool Mississauga = false;
  bool Toronto = false;

  List<AllCitys>? posts;


  void _modalBottomSheetMenu(context){
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        width: double.infinity,
        height: 420,
        decoration: const BoxDecoration(color: Colors.white ,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Stack(
          children:[
            const Positioned(
              top: 40,
              left: 10,
              child:  Text("Select City" , style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold
              ),),
            ),
            Expanded(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    FutureBuilder<List<AllCitys>>(
                      future: fetchPosts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData){
                          posts = snapshot.data;
                          return Padding(
                            padding: const EdgeInsets.only(left: 40 , top: 60),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: posts!.map((post) => Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Column(
                                    children: <Widget>[
                                      Text(post.regionName , style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold ,
                                        fontFamily: 'Ubuntu',
                                      ),),
                                    ],
                                  ),
                                )).toList()
                            ),
                          );
                        }
                        return Center(
                          child: Column(
                            children: const <Widget>[
                              Padding(padding: EdgeInsets.all(50.0)),
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 82,
                left: -20,
                right: 2,
                child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: Etobicoke,
                onChanged: (value) {
                  setState(() {
                    Etobicoke = !Etobicoke;
                  });
                },
            )),
            Positioned(
                top: 142,
                left: -20,
                right: 2,
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: Mississauga,
                  onChanged: (value) {
                    setState(() {
                      Mississauga = !Mississauga;
                    });
                  },
                )),
            Positioned(
                top: 202,
                left: -20,
                right: 2,
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: Toronto,
                  onChanged: (value) {
                    setState(() {
                      Toronto = !Toronto;
                    });
                  },
                )),
            Positioned(
              top: 360,
              left: 40,
              right: 40,
              child: GestureDetector(
              onTap: (){

              },
              child: Container(
                width: 80,
                height: 40,
                decoration: const BoxDecoration(
                    color: constants.blue2,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: const Center(
                  child: Text("Select Area" ,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu' ,
                    ),),
                ),
              ),
            ),),
          ],
        ),
      ),
    );
  }
}
