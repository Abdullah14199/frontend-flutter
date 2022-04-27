import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/models/request_details_model.dart';
import 'package:skep_home_pro/models/serviceRequestModel.dart';
import '../MyBooking/requests_details.dart';
import '../models/check_list_model.dart';
import '../models/my_booking_model.dart';
import '../models/service_request_list_model.dart';
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

}