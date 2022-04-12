import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/models/extra_service_model.dart';
import '../MyBooking/requests_details.dart';
import '../models/check_list_model.dart';
import '../models/my_booking_model.dart';
import 'complete_controller.dart';

class ExtraServiceListController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    getCheckListMainService();
  }

  ExtraServiceListModel? extraServiceListModel;
  List<ExtraService> extraService = [];

  bool verifyed = true;
  bool isLoading = false;

  void getCheckListMainService() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
// print('..>>>>>>>>>>>>>>>>>>>${pref.get('token3').toString()}');
    final response = await http.get(
      Uri.parse('http://staging.skephome.com/api/Checklist/GetChecklist/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization' : "Bearer ${pref.get('token3').toString()}"
      },
    );

    var body = response.body;
    var read = jsonDecode(body);

    if (response.statusCode == 200) {

      extraServiceListModel =  ExtraServiceListModel.fromJson(read);

      extraServiceListModel!.extraServices.forEach((element) {
        extraService.add(element);
      });

      isLoading =true;

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