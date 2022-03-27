import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart' as place;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Dashboard/service_request.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:http/http.dart' as http;
import 'package:skep_home_pro/models/userModelSignUp.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_maps_webservice/places.dart';

class Registration extends StatefulWidget {
  final String phone;

  const Registration({required this.phone});

  @override
  State<Registration> createState() => _RegistrationState();
}

const kGoogleApiKey = "AIzaSyCCHzYB_WUozqkw2mntxWDwzCAxLfKqZWM";


class _RegistrationState extends State<Registration> {
  DateTime selectedDate = DateTime.utc(1950);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2003));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    _controllerDate.text = picked.toString().substring(0,10);
  }

  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();

  Future<CallApi>? _futureAlbum;

  String location = "Search Location";

  DateTime? birthdate;

  Future<CallApi> createAlbum(String first_name, String last_name, String email,
      String date, String address) async {
    print(_controllerDate.text);
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/Auth/Register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'date_of_birth': _controllerDate.text,
        'address': address,
        'lat': "43.651070",
        'lng': "-79.347015",
        'phone': widget.phone,
      }),
    );
    var body = response.body;
    var BarearToken = jsonDecode(body);
    print(BarearToken['accessToken']);

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', BarearToken['accessToken']);

    if (response.statusCode == 200) {
      // then parse the JSON.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => backGroundCheck()),
      );
      print(response.body);
      return CallApi.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      print(response.statusCode);
      print(response.body);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Sorry.'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('The email has already been taken.'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Approve'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      print("Hohohohoh");
      throw Exception('Failed to create album.');
    }
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  final Mode _mode = Mode.overlay;





  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
        offset: 0,
        radius: 10000,
        strictbounds: false,
        region: "en",
        language: "en",
        context: context,
        mode: _mode,
        apiKey: kGoogleApiKey,
        types: ["(cities)"],
        hint: "Search City",
      components: countrys,
    );
    print(p!.description);
    displayPrediction(p);
  }


  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);
      // final lat = detail.result.geometry!.location.lat;
      // final lng = detail.result.geometry!.location.lng;
      print('p.descriptionp.description${p.description}');
      _controllerAddress.text = p.description!;



    }
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState!.showSnackBar(
      SnackBar(content: Text(response.errorMessage!)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.disabled,
        key: formkey,
        child: Stack(
          children: [
            const Positioned(
              top: 0,
              right: 15,
              left: 15,
              child: Text(
                "Complete your Data.",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 15,
              right: 220,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: 'First name',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: constants.grey),
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
                        borderSide:
                            const BorderSide(width: 2, color: constants.grey),
                        borderRadius: BorderRadius.circular(15))),
                controller: _controllerFirstName,
              ),
            ),
            Positioned(
              top: 40,
              left: 220,
              right: 15,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Last name',
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: constants.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: constants.grey),
                      borderRadius: BorderRadius.circular(15)),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                controller: _controllerLastName,
              ),
            ),
            Positioned(
              top: 130,
              left: 15,
              right: 15,
              child: TextFormField(
                validator: MultiValidator([
                  EmailValidator(errorText: "Not A Valid Email"),
                  RequiredValidator(errorText: "Required"),
                ]),
                decoration: InputDecoration(
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: constants.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: constants.grey),
                      borderRadius: BorderRadius.circular(15)),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                controller: _controllerEmail,
              ),
            ),
            Positioned(
              top: 220,
              right: 15,
              left: 15,
              child: TextField(
                controller: _controllerDate,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                  fillColor: constants.grey,
                  labelText: "${selectedDate.toLocal()}".split(' ')[0],
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: constants.grey),
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
                      borderSide:
                          const BorderSide(width: 2, color: constants.grey),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            Positioned(
              top: 310,
              left: 15,
              right: 15,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  } else {
                    return null;
                  }
                },
                controller: _controllerAddress,
                onTap: () async {
                  await _handlePressButton();
                },

                // with some styling
                decoration: InputDecoration(
                  fillColor: constants.grey,
                  labelText: "Address",
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: constants.grey),
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
                    borderSide:
                        const BorderSide(width: 2, color: constants.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 400,
              left: 15,
              right: 15,
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Referral Code ( optional )',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: constants.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: constants.grey),
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            const Positioned(
              top: 665,
              right: 15,
              left: 15,
              child: Text(
                "By signing up you are ready to accept the",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.normal),
              ),
            ),
            const Positioned(
              top: 665,
              right: 15,
              left: 280,
              child: Text(
                "privacy policy",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.normal,
                    color: constants.blue2),
              ),
            ),
            const Positioned(
              top: 680,
              right: 15,
              left: 15,
              child: Text(
                "&",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.normal),
              ),
            ),
            const Positioned(
              top: 680,
              right: 15,
              left: 28,
              child: Text(
                "terms & conditions",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.normal,
                    color: constants.blue2),
              ),
            ),
            Positioned(
              top: 700,
              left: 15,
              right: 15,
              child: Container(
                width: double.infinity,
                height: 50,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_back),
                      label: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(constants.blue2),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    side: BorderSide(color: constants.blue2))),
                      ),
                      onPressed: () {
                        if (_controllerFirstName.text.isEmpty ||
                            _controllerLastName.text.isEmpty ||
                            _controllerEmail.text.isEmpty ||
                            _controllerAddress.text.isEmpty) {
                          validate();
                        } else {
                          setState(() {
                            _futureAlbum = createAlbum(
                              _controllerFirstName.text,
                              _controllerLastName.text,
                              _controllerEmail.text,
                              _controllerDate.text,
                              _controllerAddress.text,
                            );
                          });
                        }
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  void validate() {
    if (formkey.currentState!.validate()) {
      print("Validate");
    } else {
      print("Not Validate");
    }
  }
  List<Component> countrys=[];

  void listBuildCountry(){
    for(int i =0;i<constants.listBuildCodeCountry.length;i++){
      countrys.add(Component(Component.country, constants.listBuildCodeCountry[i]));
    }
    print(countrys);
  }

}



