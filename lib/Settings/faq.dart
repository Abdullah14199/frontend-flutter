import 'package:flutter/material.dart';


class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  final items = ['One'];
  String selectedValue = 'One';

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
            ListView(
              shrinkWrap: true,
              children: [
                Card(
                  elevation: 3,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                 child: DropdownButton<String>(
                   value: selectedValue,
                   onChanged: (newValue) =>
                       setState(() => selectedValue = newValue!),
                   items: items.map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                         value: value,
                         child: Text(value),
                       ))
                       .toList(),
                   // add extra sugar..
                   icon: Icon(Icons.arrow_drop_down),
                   iconSize: 42,
                   underline: SizedBox(),
                 ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
