import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../MyBooking/requests_details.dart';
import '../models/check_list_model.dart';
import '../models/my_booking_model.dart';
import 'complete_controller.dart';

class CheckListController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    getCheckListMainService();
  }

  CheckListModel? checkListModel;
  List<MainService> mainServiceList = [];

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

      checkListModel =  CheckListModel.fromJson(read);

      checkListModel!.mainServices.forEach((element) {
        mainServiceList.add(element);
      });

      isLoading =true;

      print(mainServiceList);
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