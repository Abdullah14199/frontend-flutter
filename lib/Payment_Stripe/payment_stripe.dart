import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:http/http.dart' as http;
import 'package:skep_home_pro/controllers/stripeController.dart';

class PaymentStripe extends StatefulWidget {
  const PaymentStripe({Key? key}) : super(key: key);

  @override
  State<PaymentStripe> createState() => _PaymentStripeState();
}

class _PaymentStripeState extends State<PaymentStripe> {

  Map<String, dynamic>? paymentIntentData;
  bool ?valuefirst = false;
  bool isVisable = true;


  final paymentController = Get.put(PaymentController());
  final TextEditingController _controllerAccountNumber = TextEditingController();
  final TextEditingController _controllerHolderName = TextEditingController();
  final TextEditingController _controllerTransitNumber = TextEditingController();
  final TextEditingController _controllerInstitutionNumber = TextEditingController();

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
                        color: isVisable ? constants.Ogrey : constants.yellow
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
                                    hintText: isVisable ? 'xxxx xxxx xxxx' : _controllerAccountNumber.text,
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
                                    hintText: isVisable ? '11000' : _controllerTransitNumber.text,
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
                                    hintText: isVisable ? '000' : _controllerInstitutionNumber.text,
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
                    child: isVisable ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: constants.yellow,
                      ),
                      onPressed: () async{
                        _modalBottomSheetMenu(context);
                        setState(() {
                          isVisable = !isVisable;
                        });
                      },
                      child: Text("Add Bank Account"),
                    ) : SizedBox() )
              ],
            ),
          )

        ],
      ),
    ));
  }



  void _modalBottomSheetMenu(context){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(builder: (context, setState) => Container(
        width: double.infinity,
        height: 450,
        decoration: const BoxDecoration(color: Colors.white ,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Padding(
              padding: const EdgeInsets.only(left: 140.0 , right: 40.0 , top: 10),
              child: Container(
                width: 150,
                height: 5,
                decoration: const BoxDecoration(
                  color: constants.grey,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0 , right: 40.0 , top: 20),
              child:  Text("Add new Bank Account" , style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0 , top: 15),
              child: Text("Account Number"),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0 , right: 10),
              child: Container(
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu', color: Colors.white),
                    enabled: true,
                    border: OutlineInputBorder(
                      borderSide: new BorderSide(color: constants.grey),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: constants.grey),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: constants.grey),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: constants.grey),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                  ),
                  controller: _controllerAccountNumber,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0 , top: 15),
              child: Text("Account Holder's Name"),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0 , right: 10),
              child: Container(
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu', color: Colors.white),
                    enabled: true,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color:constants.grey),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: constants.grey),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                  ),
                  controller: _controllerHolderName,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text("Transit number", style: TextStyle(fontWeight: FontWeight.normal , fontFamily: 'Ubuntu' , fontSize: 14)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0 ,top: 5 , bottom: 8),
                        child: Text("Your 5 digit Transit Number" ,style: TextStyle(fontWeight: FontWeight.normal , fontFamily: 'Ubuntu' , fontSize: 12 , color: constants.grey),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0 , right: 10),
                        child: Container(
                          width: 150,
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu', color: Colors.white),
                              enabled: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: constants.grey),
                                borderRadius: new BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: constants.grey),
                                borderRadius: new BorderRadius.circular(10),
                              ),
                            ),
                            controller: _controllerTransitNumber,

                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15 , right: 15),
                        child: Text("Institution number" , style: TextStyle(fontWeight: FontWeight.normal , fontFamily: 'Ubuntu' , fontSize: 14),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0 ,top: 5 , bottom: 8 , right: 7),
                        child: Text("Your 3 digit Institution number", style: TextStyle(fontWeight: FontWeight.normal , fontFamily: 'Ubuntu' , fontSize: 12 , color: constants.grey),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0 , right: 10),
                        child: Container(
                          width: 150,
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'Ubuntu', color: Colors.white),
                              enabled: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: constants.grey),
                                borderRadius: new BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: constants.grey),
                                borderRadius: new BorderRadius.circular(10),
                              ),
                            ),
                            controller: _controllerInstitutionNumber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6 , top: 3),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.greenAccent,
                    activeColor: Colors.blue,
                    value: valuefirst,
                    onChanged: (value) {
                      setState(() {
                        valuefirst = value;
                      });
                    },
                  ),
                  Text("I agree to") ,
                  Text(" Privacy Policy." , style: TextStyle(color: Colors.blue),) ,
                  Text(" &") ,
                  Text(" Services & Agreements" , style: TextStyle(color: Colors.blue))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0 , right: 8, top: 5),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: constants.yellow,
                  ),
                  onPressed: () {
                    paymentController.makePayment(accountNum: _controllerAccountNumber.text.toString() ,holderName: _controllerHolderName.text , transitNum: _controllerTransitNumber.text ,institutionNum: _controllerInstitutionNumber.text);
                    Navigator.pop(context);
                    },
                  child: Text("Add Bank Account"),
                ),
              ),
            )
          ] ,
        ),
      ),),
    );
  }

}
