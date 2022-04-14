import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/models/request_details_model.dart';

import '../controllers/support_center_by_id-controller.dart';

class SupportCenter extends StatefulWidget {
  String jobId;

  SupportCenter({Key? key , required this.jobId}) : super(key: key);

  @override
  State<SupportCenter> createState() => _SupportCenterState();
}

class _SupportCenterState extends State<SupportCenter> {
  late TextEditingController _controllerTitle = TextEditingController();
  late TextEditingController _controllerDescription = TextEditingController();

  bool isButtonActive = false ;

  @override
  void initState(){
    super.initState();

    _controllerTitle = TextEditingController();
    _controllerDescription = TextEditingController();

    _controllerDescription.addListener(() {
      final isButtonActive = _controllerDescription.text.isNotEmpty;

      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose(){
    _controllerTitle.dispose();
    _controllerDescription.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
                Center(child: Text("Please submit a ticket and we will get back to you as." , style: TextStyle(fontSize: 12 , fontWeight: FontWeight.normal , fontFamily: 'Ubuntu' , color: constants.grey),)),
                Center(child: Text("soon as possible." , style: TextStyle(fontSize: 12 , fontWeight: FontWeight.normal , fontFamily: 'Ubuntu' , color: constants.grey),)),
                const Padding(
                  padding: EdgeInsets.only(top: 15 , bottom: 7 , left: 3),
                  child: Text("Title"),
                ),
                TextFormField(
                  controller: _controllerTitle,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20),
                      hintText: 'Issue',
                      hintStyle: TextStyle(fontSize: 12, color: constants.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: constants.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 2, color: constants.grey),
                          borderRadius: BorderRadius.circular(8))),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 14.0 , bottom: 7 , left: 3),
                  child: Text("Description"),
                ),
                Container(
                  child: TextFormField(
                    controller: _controllerDescription,
                    maxLines: 20,
                    minLines: 20,
                    decoration: InputDecoration(
                        hintMaxLines: 10,
                        contentPadding: EdgeInsets.only(left: 20 , top: 20),
                        hintStyle: TextStyle(fontSize: 12 , color: constants.grey),
                        hintText: "Please describe the problem you are facing",
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 3, color: constants.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 2, color: constants.grey),
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Container(
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
                            backgroundColor: isButtonActive ?  MaterialStateProperty.all<Color>(constants.blue4) : MaterialStateProperty.all<Color>(constants.grey),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                 RoundedRectangleBorder(
                                    borderRadius:  BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),bottomRight: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                                    side: BorderSide(color: isButtonActive ? constants.blue4 : constants.grey)
                                )
                            ),
                          ),
                          onPressed: isButtonActive ? () {
                            setState( () => isButtonActive = false );
                            controller.getSupportCenter(_controllerTitle.text, _controllerDescription.text , widget.jobId , context);
                          } : null
                      ),
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

