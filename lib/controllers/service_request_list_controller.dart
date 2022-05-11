import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/models/request_details_model.dart';
import 'package:skep_home_pro/models/serviceRequestModel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Back_ground_check/back_ground_check.dart';
import '../Dashboard/service_request.dart';
import '../MyBooking/requests_details.dart';
import '../models/CheckListModel.dart';
import '../models/UserModel.dart';
import '../models/check_list_model.dart';
import '../models/my_booking_model.dart';
import '../models/service_request_list_model.dart';
import '../models/updateProfileApi.dart';
import 'complete_controller.dart';

class ServiceRequestListController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    getServiceRequestList();
  }

  ServiceRequestListModel? serviceRequestModel;
  List<ServiceRequestList> serviceRequestList = [];

  bool verifyed = true;
  bool isLoading = false;
  var read;

  void getServiceRequestList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
// print('..>>>>>>>>>>>>>>>>>>>${pref.get('token3').toString()}');
    final response = await http.get(
      Uri.parse('http://staging.skephome.com/api/ServiceRequest/ServiceRequest'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization' : "Bearer ${pref.get('token3').toString()}"
      },
    );

    var body = response.body;
    read = jsonDecode(body);

    if (response.statusCode == 200) {

      serviceRequestModel =  ServiceRequestListModel.fromJson(read);

      serviceRequestModel!.serviceRequest.forEach((element) {
        serviceRequestList.add(element);
      });

      isLoading =true;

      print(body);



      print(response.statusCode);


    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      print(response.statusCode);
      throw Exception('Failed to create album.');
    }

    update();
  }

  void postAccept(int idServiceRequest) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/ServiceRequest/AcceptAppointment'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization' : "Bearer ${pref.get('token3').toString()}"
      },
      body: {
        "booking_id" : idServiceRequest.toString()
      }
    );

    var body = response.body;
    var read = jsonDecode(body);
    if (response.statusCode == 200) {
      print(body);
      print(response.statusCode);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      print(response.statusCode);
      throw Exception('Failed to create album.');
    }

    update();
  }

  void postReject(int idServiceRequest) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse('http://staging.skephome.com/api/ServiceRequest/RefuseService'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization' : "Bearer ${pref.get('token3').toString()}"
        },
        body: {
          "booking_id" : idServiceRequest.toString()
        }
    );

    var body = response.body;
    var read = jsonDecode(body);
    if (response.statusCode == 200) {
      print(body);
      print(response.statusCode);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      print(response.statusCode);
      throw Exception('Failed to create album.');
    }

    update();
  }

  CheckListModels ? checkListModels ;

  void checkService(context) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response =await http
        .get(Uri.parse('https://staging.skephome.com/api/ServiceRequest/CheckServiceRequest'),
        headers: {
          HttpHeaders.authorizationHeader : 'Bearer ${pref.get('token3').toString()}'
        }
    );

    var body =response.body;
    var visiable = json.decode(body);
    print(visiable['Checklist'][0]["Visable"]);
    final responseJson = jsonDecode(response.body);
    if(response.statusCode == 200){
      print(responseJson);
      checkListModels =  CheckListModels.fromJson(responseJson);

    }else{

      print(response.statusCode);
      throw Exception('Failed to load album');
    }
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
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        print(response.statusCode);
        print(response.body);
        throw Exception('${response.statusCode} ${response.body}');
      }
    });
  }


  Future<userProfileModel> editUserData(File? image) async {
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

  void _launchURL() async {
    String url = Url_redrict;
    if (!await launch(url)) throw 'Could not launch $url';
  }


  void postCertn() async {
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

    } else {

      print(response.statusCode);
      print(response.body);
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

}