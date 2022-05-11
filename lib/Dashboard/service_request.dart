import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Dashboard/areaOfWork.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/models/CertnModel.dart';
import 'package:skep_home_pro/models/updateProfileApi.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../models/UserModel.dart';

class service_request extends StatefulWidget {
  @override
  State<service_request> createState() => _service_requestState();
}

var Email;
var First_name;
var Last_name;
var Date_of_birth;
var Phone_Number;
var Selfie;
var IDCertn;
var IDInfo;
var Url_redrict ;


class _service_requestState extends State<service_request> {
  double _value = 0.5;
  int currentIndex = 0;

  PageController _pageController = PageController();

  Future<userProfileModel>? _futureAlbum;

  File? _file;


  @override
  void initState() {
    super.initState();
    level();
  }

  // Future<ServiceRequestModel> fetchData(context) async{
  //   final response =await http
  //       .get(Uri.parse('https://staging.skephome.com/api/ServiceRequest/CheckServiceRequest'),
  //       headers: {
  //         HttpHeaders.authorizationHeader : 'Bearer $token'
  //       }
  //   );
  //
  //   var body =response.body;
  //   var type = json.decode(body);
  //   print(type["Checklist"][1]["type"]);
  //   var visiable = json.decode(body);
  //   print(visiable['Checklist'][0]["Visable"]);
  //   final responseJson = jsonDecode(response.body);
  //   if(response.statusCode == 200){
  //     print(response.body);
  //     if(type["Checklist"][0]["type"]==1){
  //       if(visiable['Checklist'][0]["Visable"]==true){
  //         if(type["Checklist"][1]["type"]==2){
  //           if(visiable['Checklist'][1]["Visable"]==true){
  //             if(type["Checklist"][2]["type"]==3){
  //               if(visiable['Checklist'][2]["Visable"]==true){
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) =>  Registration(phone: widget.phone)),
  //                 );
  //               }
  //             }
  //           }
  //         }
  //       }
  //     }
  //     return ServiceRequestModel.fromJson(responseJson);
  //   }else{
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => service_request()),
  //     );
  //     print(response.statusCode);
  //     throw Exception('Failed to load album');
  //   }
  // }

  //late Future<ServiceRequestModel> checkServiceRequest;



  Future pickCamera() async {
    final myFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 60);
    setState(() {
      _file = File(myFile!.path);
      if (_file == null) return;
      _futureAlbum = editUserData(_file);
    });
  }

  static Future<userProfileModel> editUserData(File? image) async {
    String basicAuth = 'Bearer $token';
    var uri = Uri.parse("http://staging.skephome.com/api/User/UpdateProfile");
    var request = http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = basicAuth;

    image != null
        ? request.files
            .add(await http.MultipartFile.fromPath('selfie', image.path))
        : request.fields['selfie'];
    http.Response response =
        await http.Response.fromStream(await request.send());
    print(response.body);
    var body = response.body;
    Email = json.decode(body);

    var selfie = jsonDecode(body);
    Selfie = selfie['user']['selfie'];

    print(Email['email']);
    return userProfileModel.fromJson(JsonDecoder().convert(utf8.decode(response.bodyBytes)));
  }

  void createAlbum() async {
    await getDataUser().then((value) async {
      print(value.email);
      final response = await http.post(
          Uri.parse('https://demo-api.certn.co/hr/v1/applications/quick/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer eb61ad0d8242c9ec232c74afadc18d685fccc650'
          },
          body: jsonEncode(<String, dynamic>{
            "request_enhanced_criminal_record_check": true,
            "request_enhanced_identity_verification": true,
            "email": Email,
            "information": {
              "first_name": First_name,
              "last_name": Last_name,
              "date_of_birth": Date_of_birth,
              "birth_city": "Victoria",
              "birth_province_state": "BC",
              "birth_country": CodeCountry2,
              "gender": Gender,
              "phone_number": Phone_Number,
              "addresses": [{
                "address": "4412 King Alfred Court",
                "city": "Victoria",
                "province_state": "BC",
                "country": "CA"
              }],
              "convictions": [{
                "offense": "332",
                "date_of_sentence": "2000-01-01",
                "court_location": "Victoria, BC, Canada",
                "description": "Robbery; Theft over 200"
              }, {
                "offense": "348",
                "date_of_sentence": "2000-01-01",
                "court_location": "Victoria, BC, Canada",
                "description": "Break, enter, and theft"
              }
              ],
              "rcmp_consent_given": true
            }
          })
      );
      var body = response.body;
      if (response.statusCode == 201) {
        // then parse the JSON.

        var id_certn = jsonDecode(body);
        IDCertn = id_certn["id"];

        var url = jsonDecode(body);
        Url_redrict = url['enhanced_identity_verification']['redirect_url'];

         postCertn();

        _launchURL();

        print(body);
        return CertnModel.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        showDialog(
            context: context,
            builder: (context) {
              return Text('${response.statusCode} ${response.body}');
            });
        print(response.statusCode);
        print(response.body);
        throw Exception('${response.statusCode} ${response.body}');
      }
    });
  }

  void _launchURL() async {
    String url = Url_redrict;
    if (!await launch(url)) throw 'Could not launch $url';
  }


  Future<CertnModel> postCertn() async {
    final response = await http.post(
      Uri.parse('https://staging.skephome.com/api/Auth/CertnID/$IDInfo'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String , String>{
        'certn_id': IDCertn,
      }),
    );
    var body = response.body;
    var respSt= response.statusCode;
    if (response.statusCode == 200) {
      // then parse the JSON.
      print(body);
      print("Succeed");
      return CertnModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.statusCode);
      print(response.body);
      showDialog(
          context: context,
          builder: (context) {
            return Text(IDInfo.toString() +"     "+  body);
          });
      print("Hohohohoh");
      throw Exception('Failed to create album.');
    }
  }


  Future<UserModel> getDataUser() async {
    final response = await http.get(
        Uri.parse('http://staging.skephome.com/api/User/MyProfile'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    if (response.statusCode == 200) {
      var body = response.body;

      var email = jsonDecode(body);
      Email = email['user']['email'];
      var firstName = jsonDecode(body);
      First_name =firstName['user']['first_name'];
      var lastName = jsonDecode(body);
      Last_name = lastName['user']['last_name'] ;
      var dateOfBirth = jsonDecode(body);
      Date_of_birth = dateOfBirth['user']['date_of_birth'] ;
      var gender = jsonDecode(body);
      Gender = gender['user']['gender'] ;
      var phone = jsonDecode(body);
      Phone_Number= phone['user']['phone'];

      var id_info = jsonDecode(body);
      IDInfo = id_info['user']['id'];


      print(response.body);
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      print(response.statusCode);
      throw Exception(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {



    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        token = sharedPrefValue.getString('token')!;
        // print(token);
      });
    });

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
          title: const Padding(
            padding: EdgeInsets.only(left: 70),
            child: Text(
              "Request Details",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
        ),
        drawer: ClipRRect(
          child: Drawer(
            backgroundColor: Colors.white,
            child: ListView(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 150,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: constants.blue2,
                    ),
                    child: Stack(children: [
                      Positioned(
                        child:
                        Image.asset("assets/images/profile_decore_img.png"),
                        top: 10,
                        bottom: 30,
                      ),
                      Positioned(
                        top: 70,
                        left: 145,
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              const Text(
                                "Edit Profile",
                                style: TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  "assets/images/edit.png",
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        left: 13,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://staging.skephome.com/storage/${Selfie}"),
                          radius: 30,
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 100,
                        right: 40,
                        child: Text(
                          "Hi ${FirstName} , ",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu '),
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 100,
                        right: 40,
                        child: Text(
                          "Welcome Back",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu '),
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 95,
                        child: Container(
                          width: 60,
                          height: 100,
                          child: IconButton(
                            onPressed: () {},
                            icon: Silver == true
                                ? Image.asset(
                              "assets/images/silver_badge_img.png",
                              width: 200,
                              height: 69,
                            )
                                : Gold == true
                                ? Image.asset(
                                "assets/images/gold_shield_img.png",
                                width: 200,
                                height: 69)
                                : Image.asset(
                                "assets/images/bronz_badge_img.png",
                                width: 200,
                                height: 69),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 73,
                        left: 160,
                        child: Container(
                          width: 50,
                          height: 15,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: const Text(
                            "    Great",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        left: 150,
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                          AssetImage("assets/images/ic_colored_great.PNG"),
                          radius: 10,
                        ),
                      ),
                    ]),
                  ),
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  selected: true,
                  leading: Image.asset(
                    "assets/images/homeMenu.png",
                    color: constants.blue2,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: constants.grey,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  selected: true,
                  leading: Image.asset(
                    "assets/images/shield.png",
                    color: constants.blue2,
                  ),
                  title: const Text('Account verification',
                      style: TextStyle(color: Colors.black)),
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: constants.grey,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  selected: true,
                  leading: Image.asset(
                    "assets/images/calendar-4.png",
                    color: constants.blue2,
                  ),
                  title: const Text('My Bookings',
                      style: TextStyle(color: Colors.black)),
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: constants.grey,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  selected: true,
                  leading: Image.asset(
                    "assets/images/credit-card.png",
                    color: constants.blue2,
                  ),
                  title: const Text('Payment Options',
                      style: TextStyle(color: Colors.black)),
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: constants.grey,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  selected: true,
                  leading: Image.asset(
                    "assets/images/address.png",
                    color: constants.blue2,
                  ),
                  title: const Text('Area Of Work',
                      style: TextStyle(color: Colors.black)),
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: constants.grey,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  selected: true,
                  leading: Image.asset(
                    "assets/images/settings.png",
                    color: constants.blue2,
                  ),
                  title: const Text('Settings',
                      style: TextStyle(color: Colors.black)),
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: constants.grey,
                ),
                ListTile(

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  selected: true,
                  leading: Image.asset(
                    "assets/images/group.png",
                    color: constants.blue2,
                  ),
                  title: const Text('Referral Program',
                      style: TextStyle(color: Colors.black)),
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: constants.grey,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  selected: true,
                  leading: Image.asset(
                    "assets/images/support.png",
                    color: constants.blue2,
                  ),
                  title: const Text('Support Center',
                      style: TextStyle(color: Colors.black)),
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: constants.grey,
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Positioned(
                      left: 60,
                      child: Image.asset("assets/images/service_request.png")),
                  const Positioned(
                    top: 280,
                    left: 40,
                    right: 40,
                    child: Center(
                      child: Text(
                        "Skep Pro Services helps you find the best.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 298,
                    left: 60,
                    right: 60,
                    child: Center(
                      child: Text(
                        "cleaning job opportunities near you by",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 316,
                    left: 60,
                    right: 60,
                    child: Center(
                      child: Text(
                        "connecting you to local homeowners.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Positioned(
                    right: 14,
                    left: 14,
                    child: Container(
                      width: double.infinity,
                      height: 280,
                      child: PageView(
                        controller: _pageController,
                        children: [
                          _backgroundCheck('Background check', Colors.white),
                          _page('Profile Picture', Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                  top: 680,
                  left: 350,
                  right: 15,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 2,
                    effect: WormEffect(),
                    onDotClicked: (index) => _pageController.animateToPage(
                        index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.bounceOut),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _page(String s, Color color) {
    return Container(
        color: color,
        child: Stack(children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 3,
                color: constants.grey,
              )),
          Positioned(
            top: 15,
            left: 15,
            right: 15,
            child: Text(
              s,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          Positioned(
            top: 15,
            left: 300,
            right: 20,
            child: ElevatedButton(
              child: const Text("Upload Now",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu',
                  )),
              onPressed: () {
                setState(() {
                  pickCamera();
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(constants.blue2),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        side: BorderSide(color: constants.blue2))),
              ),
            ),
          ),
          const Positioned(
            top: 36,
            left: 15,
            right: 15,
            child: Text(
              "Take a real profile picture",
              style: TextStyle(
                  color: constants.blue2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          const Positioned(
            top: 70,
            left: 15,
            right: 15,
            child: Text(
              "Your photo will make it easier for homeowners to Recognize you.",
              style: TextStyle(
                  color: constants.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          const Positioned(
              top: 257,
              right: 30,
              left: 320,
              child: Text(
                "2/2",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.normal,
                ),
              ))
        ]));
  }

  _backgroundCheck(String s, Color color) {
    return Container(
      color: color,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 3,
                color: constants.grey,
              )),
          Positioned(
            top: 15,
            left: 15,
            right: 15,
            child: Text(
              s,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          Positioned(
              top: 15,
              left: 250,
              right: 15,
              child: ElevatedButton(
                  child: Text("Complete Now"),
                  onPressed: () {
                      createAlbum();
                      // postCertn();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(constants.blue2),
                    shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            side: BorderSide(color: constants.blue2))),
                  ),
                ),
              ),
          const Positioned(
            top: 36,
            left: 15,
            right: 15,
            child: Text(
              "3 steps left",
              style: TextStyle(
                  color: constants.blue2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          Positioned(
            top: 70,
            left: 15,
            right: 15,
            child: Container(
              width: 40,
              height: 10,
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  value: 0,
                  valueColor: AlwaysStoppedAnimation<Color>(constants.yellow),
                  backgroundColor: constants.grey,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 90,
            left: 15,
            right: 15,
            child: Text(
              "You’ll have to complete this and be approved before starting Receiving new jobs. ",
              style: TextStyle(
                  color: constants.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          Positioned(
              top: 140,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 3,
                color: constants.grey,
              )),
          Positioned(
            top: 160,
            left: 15,
            right: 15,
            child: Text(
              "Area of work",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          Positioned(
              top: 160,
              left: 280,
              right: 15,
              child: ElevatedButton(
                child: Text("Set Now"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AreaOfWork()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(constants.blue2),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          side: BorderSide(color: constants.blue2))),
                ),
              )),
          const Positioned(
            top: 181,
            left: 15,
            right: 15,
            child: Text(
              "Select multiple working areas",
              style: TextStyle(
                  color: constants.blue2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          const Positioned(
            top: 215,
            left: 15,
            right: 15,
            child: Text(
              "We will help you with finding the best working opportunities In your selected working areas",
              style: TextStyle(
                  color: constants.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu',
                  fontSize: 14),
            ),
          ),
          const Positioned(
              top: 257,
              right: 30,
              left: 320,
              child: Text(
                "1/2",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.normal,
                ),
              ),
          ),
        ],
      ),
    );
  }
}

bool Silver = false ;
bool Gold = false ;
bool Platinum = false ;

void level(){
  if(Level == 'one'){
    Image.asset("assets/images/bronz_badge_img.png");
    Silver = true;
  }else if(Level == 'two'){
    Image.asset("assets/images/bronz_badge_img.png");
    Gold = true;
  }else if(Level == 'three'){
    Image.asset("assets/images/bronz_badge_img.png");
    Platinum = true;
  }
}