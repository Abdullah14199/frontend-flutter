import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/MyBooking/requests_details.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment({required String accountNum , required String institutionNum , required String holderName , required String transitNum}) async {
    try {
      paymentIntentData = await createPaymentIntent(accountNum , holderName  , transitNum , institutionNum );
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              applePay: true,
              googlePay: true,
              testEnv: true,
              merchantCountryCode: 'US',
              merchantDisplayName: 'Prospects',
              customerId: paymentIntentData!['customer'],
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
            ));
        displayPaymentSheet();
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar('Payment', 'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }
var idTokStr;

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String accountNum , String holderName ,String institutionNum , String transitNum) async {
    try {
      Map<String, dynamic> body = {
        // 'payment_method_types[]': 'card',
         "bank_account[country]" : "CA" ,
         "bank_account[currency]": "CAD" ,
         "bank_account[account_holder_name]": holderName ,
        "bank_account[routing_number]" : "${transitNum}${institutionNum}",
        "bank_account[account_number]": accountNum
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/tokens'),
          body: body,
          headers: {
            'Authorization': 'Bearer sk_test_51KqbfwGDR1ZdiamS000tdklMmuhyeBwSssxBZtLPTlP4Sl25lu48vXADAhRZ8NsEYztelmnXLvqrYjuMhOQBhLr600fg9DV9wZ',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      var body2 = response.body;
      var gender = jsonDecode(body2);
      idTokStr = gender['id'] ;

      if(response.statusCode == 200){
        print("SAKSJDSJKADHKSJADHKJ $idTokStr");
        print(response.body);
        postIDToken();

        return jsonDecode(response.body);


      }else{
        print(response.statusCode);
        print(response.body);
      }


    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }





    void postIDToken() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final response = await http.post(
      Uri.parse('http://staging.skephome.com/api/Stripe/saveBankActToken'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization' : "Bearer ${pref.get('token3').toString()}"
      },
      body: jsonEncode(<String, String>{
        'bankToken': idTokStr,
      }),
    );

    final responseJson = jsonDecode(response.body);
    var body = response.body;


    if (response.statusCode == 200) {
      print("<><><><><><><><>>");
      print(body);
      print(response.statusCode);

    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to load album');
    }
  }

}