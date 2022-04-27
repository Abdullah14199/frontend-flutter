import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/controllers/settings_controller.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

final faqController = Get.put(SettingsController());

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: faqController.faqModel!.faq[index].questions,
      expandedValue: faqController.faqModel!.faq[index].answers,
    );
  });
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
            "FAQ",
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
          children: [
            const Text("Get answers to the most frequently asked questions.",  style: TextStyle(fontSize: 15 , fontFamily: 'Ubuntu')),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _data[index].isExpanded = !isExpanded;
                      });
                    },
                    children: _data.map<ExpansionPanel>((Item item) {
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(item.headerValue , style: const TextStyle(fontSize: 14 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: constants.blue4),),
                          );
                        },
                        body: ListTile(
                          title: Text(item.expandedValue , style: const TextStyle(fontSize: 14 , fontFamily: 'Ubuntu') ),
                        ),
                        isExpanded: item.isExpanded,
                      );
                    }).toList(),
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
