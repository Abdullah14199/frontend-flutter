import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/Dashboard/Dashboard.dart';
import '../MyBooking/requests_details.dart';
import '../models/check_list_model.dart';
import '../models/my_booking_model.dart';
import '../models/rating_model.dart';
import 'complete_controller.dart';

class RatingController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    getRating();
  }

  RatingModel? ratingModel;
  List<CleanerRating> cleanerRatingList = [];

  bool verifyed = true;
  var read;
  bool isLoading = false;


  void getRating() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
// print('..>>>>>>>>>>>>>>>>>>>${pref.get('token3').toString()}');
    final response = await http.get(
      Uri.parse('http://staging.skephome.com/api/Rating/CleanerReviews/${pref.get('idCleaner')}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization' : "Bearer ${pref.get('token3').toString()}"
      },
    );

    var body = response.body;
    read = jsonDecode(body);

    if (response.statusCode == 200) {

      ratingModel =  RatingModel.fromJson(read);
      ratingModel!.cleanerRatings.forEach((element) {
        cleanerRatingList.add(element);
      });


      isLoading = true;
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