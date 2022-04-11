import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:skep_home_pro/constatns/constants.dart';


class CheckList extends StatefulWidget {
  const CheckList({Key? key}) : super(key: key);

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
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
      body: SingleChildScrollView(
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
              itemCount: 5,
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

                                    // print(male.value);
                                  },
                                  size: 30,
                                  checkedColor: constants.green,
                                  uncheckedColor: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("data"),
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
            padding: const EdgeInsets.only(left: 30.0 , top: 8),
            child: Text("Extra Service"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0 , right: 20.0 , top: 4),
            child: ListView.builder(
              itemCount: 5,
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

                                    // print(male.value);
                                  },
                                  size: 30,
                                  checkedColor: constants.green,
                                  uncheckedColor: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("data"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {

                      }),
            ),
          ),
        ],),
      ),
    ));
  }
}
