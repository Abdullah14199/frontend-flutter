import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:http/http.dart' as http;

class PaymentStripe extends StatefulWidget {
  const PaymentStripe({Key? key}) : super(key: key);

  @override
  State<PaymentStripe> createState() => _PaymentStripeState();
}

class _PaymentStripeState extends State<PaymentStripe> {

  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
            "Payment Options",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Bank account" , style: TextStyle(fontSize: 16 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: Colors.black),),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Add &edit your saved back Account" ,style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.normal , color: Colors.grey)),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(top: 8.0 , left: 20 , right: 20),
            child: Stack(
              children: [
                IgnorePointer(
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: constants.Ogrey
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0 , left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Account No." , style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu', color: Colors.white),),
                              SizedBox(width: 120,),
                              Text("Holder name", style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu', color: Colors.white)),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                width:150,
                                height: 40,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: constants.lightGrey,
                                    hintText: 'xxxx xxxx xxxx',
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu', color: Colors.white),
                                    enabled: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.white),
                                      borderRadius: new BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.white),
                                      borderRadius: new BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {

                                  },
                                  onSaved: (value) {
                                  },
                                ),
                              ),
                              SizedBox(width: 40,),
                              Container(
                                width:150,
                                height: 40,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: constants.lightGrey,
                                    hintText: '$FirstName',
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu', color: Colors.white),
                                    enabled: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.white),
                                      borderRadius: new BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.white),
                                      borderRadius: new BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {

                                  },
                                  onSaved: (value) {
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text("Transit number" , style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu', color: Colors.white)),
                              SizedBox(width: 100,),
                              Text("Institution number" , style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu', color: Colors.white)),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                width:150,
                                height: 40,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: constants.lightGrey,
                                    hintText: '11000',
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu', color: Colors.white),
                                    enabled: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.white),
                                      borderRadius: new BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.white),
                                      borderRadius: new BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {

                                  },
                                  onSaved: (value) {
                                  },
                                ),
                              ),
                              SizedBox(width: 40,),
                              Container(
                                width:150,
                                height: 40,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: constants.lightGrey,
                                    hintText: '000',
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu', color: Colors.white),
                                    enabled: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.white),
                                      borderRadius: new BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.white),
                                      borderRadius: new BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {

                                  },
                                  onSaved: (value) {
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                    left: 60,
                    right: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: constants.yellow,
                      ),
                      onPressed: () {
                        print("SADASDASD");
                        makePayment();

                      },
                      child: Text("Add Bank Account"),
                    ))
              ],
            ),
          )

        ],
      ),
    ));
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              testEnv: true,
              style: ThemeMode.dark,
              merchantCountryCode: 'US',
              merchantDisplayName: 'ANNIE')).then((value){
      });
      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {

    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData!['client_secret'],
            confirmPayment: true,
          )).then((newValue){


        print('payment intent'+paymentIntentData!['id'].toString());
        print('payment intent'+paymentIntentData!['client_secret'].toString());
        print('payment intent'+paymentIntentData!['amount'].toString());
        print('payment intent'+paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;

      }).onError((error, stackTrace){
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });


    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('aaaaa$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer sk_test_51KqbfwGDR1ZdiamS000tdklMmuhyeBwSssxBZtLPTlP4Sl25lu48vXADAhRZ8NsEYztelmnXLvqrYjuMhOQBhLr600fg9DV9wZ',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print(body);
      print(response.statusCode);
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100 ;
    return a.toString();
  }

}
