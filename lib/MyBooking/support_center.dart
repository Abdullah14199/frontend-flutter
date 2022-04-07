import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/models/request_details_model.dart';

import '../controllers/support_center_by_id-controller.dart';

class SupportCenter extends StatelessWidget {
  String jobId;
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

  SupportCenter({Key? key , required this.jobId}) : super(key: key);

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
            "Support Center",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
      ),
      body: GetBuilder<SupportCenterByIdController>(
        init: SupportCenterByIdController(),
        builder: (controller)=> SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0 , left: 20 , right: 20),
                  child: Text("Please submit a ticket and we will get back to you as Soon as possible. " , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.normal , fontFamily: 'Ubuntu'),),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15 , bottom: 7 , left: 3),
                  child: Text("Title"),
                ),
                TextFormField(
                  controller: _controllerTitle,
                  decoration: InputDecoration(
                      labelText: 'Issue',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: constants.grey),
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
                          BorderSide(width: 2, color: constants.grey),
                          borderRadius: BorderRadius.circular(15))),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0 , bottom: 7 , left: 3),
                  child: Text("Description"),
                ),
                Container(
                  child: TextFormField(
                    controller: _controllerDescription,
                    maxLines: 20,
                    minLines: 20,

                    decoration: InputDecoration(
                      hintMaxLines: 10,

                        hintText: "Please describe the problem you are facing",
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 3, color: constants.grey),
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
                            BorderSide(width: 2, color: constants.grey),
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        label: const Text(
                          "Place Ticket",
                          style: TextStyle(fontSize: 14,),
                        ),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(constants.darkgrey),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                  borderRadius:  BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),bottomRight: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                                  side: BorderSide(color: constants.darkgrey)
                              )
                          ),
                        ),
                        onPressed: () {
                          controller.getSupportCenter(_controllerTitle.text, _controllerDescription.text , jobId , context);
                        }
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

