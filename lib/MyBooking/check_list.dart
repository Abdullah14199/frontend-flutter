import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/MyBooking/requests_details.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/controllers/check_list_controller.dart';
import 'package:http/http.dart' as http;
import 'package:skep_home_pro/controllers/extra_service_controller.dart';
import '../models/check_list_model.dart';
import '../models/my_booking_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class CheckList extends StatefulWidget {

  int scheduleBooking;
  CheckList({Key? key ,required this.scheduleBooking}) : super(key: key);

  @override
  State<CheckList> createState() => _CheckListState();
}


class _CheckListState extends State<CheckList> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckListController>(
      init: CheckListController(),
      builder: (controller){
        print(id);
        return SafeArea(
            child: Scaffold(
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
                    "Check list",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
              body: ConditionalBuilder(
                builder: (BuildContext context) => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0 , top: 8),
                        child: Text("Main Service"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0 , right: 20.0 , top: 4),
                        child: ListView.builder(
                          itemCount: controller.mainServiceList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 65,
                                    padding: EdgeInsets.only(
                                      left: 3,
                                      right: 0,
                                      top: 2,
                                    ),
                                    child: Card(
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RoundCheckBox(
                                              onTap: (value) {
                                                showModalBottomSheet(
                                                  context: context,
                                                  backgroundColor: Colors.transparent,
                                                  builder: (context) => Container(
                                                    width: double.infinity,
                                                    height: 350,
                                                    decoration: const BoxDecoration(color: Colors.white ,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(50),
                                                        topRight: Radius.circular(50),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children:[
                                                        Container(
                                                          width: 150,
                                                          height: 5,
                                                          decoration: const BoxDecoration(
                                                            color: constants.grey,
                                                            borderRadius: BorderRadius.all(Radius.circular(2)),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 20 , right: 20 , top: 15),
                                                          child: Center(child: Text(controller.mainServiceList[index].items.name)),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 25 , right: 25 , top: 15),
                                                          child: Center(child: Text(controller.mainServiceList[index].items.description , style: TextStyle(color: Colors.grey , fontSize: 12),)),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 20.0 , right: 10 , left: 10),
                                                          child: Container(
                                                            width: double.infinity,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(10))
                                                            ),
                                                            child: ElevatedButton(onPressed: (){
                                                              Navigator.of(context).pop();
                                                            }, child: Text("Close")),
                                                          ),
                                                        ),

                                                      ] ,
                                                    ),
                                                  ),
                                                );
                                                // print(male.value);
                                              },
                                              size: 30,
                                              checkedColor: constants.green,
                                              uncheckedColor: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text(controller.mainServiceList[index].items.name),
                                          ),
                                        ],
                                      ),

                                    ),
                                  ),
                                  onTap: () {

                                  }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 8),
                        child: Text("Extra Service"),
                      ),
                      GetBuilder<ExtraServiceListController>(
                        init: ExtraServiceListController(),
                        builder: (controller2) => Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 4),
                          child: ListView.builder(
                            itemCount: controller2.extraService.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) =>
                                GestureDetector(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 65,
                                      padding: EdgeInsets.only(
                                        left: 3,
                                        right: 0,
                                        top: 2,
                                      ),
                                      child: Card(
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: RoundCheckBox(
                                                onTap: (value) {

                                                },
                                                size: 30,
                                                checkedColor: constants.green,
                                                uncheckedColor: Colors.white,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Text(controller2.extraService[index].items.name),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {}),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                condition: controller.isLoading,
                fallback: (BuildContext context) => Center(child: CircularProgressIndicator()),
              ),
            ));
      },
    );
            }
  }




