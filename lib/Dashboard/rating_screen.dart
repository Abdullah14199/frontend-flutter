import 'package:flutter/material.dart';
import 'package:skep_home_pro/constatns/constants.dart';

class ratingScreen extends StatefulWidget {
  const ratingScreen({Key? key}) : super(key: key);

  @override
  State<ratingScreen> createState() => _ratingScreenState();
}

class _ratingScreenState extends State<ratingScreen> {



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
            "Ratings",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Client Reviews" , style: TextStyle(fontSize: 16 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold),),
            Container(
                width: 40,
                height: 60,
                child: Image.asset("assets/images/ic_great_rate.PNG")),
            Text("No Customer Ratings" , style: TextStyle(fontSize: 11 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: Colors.grey),),
            SizedBox(height: 7,),
            Row(
              children: [
                SizedBox(width: 40,),
                Text("Awesome" ,  style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: Colors.grey),) ,
                SizedBox(width: 40,),
                Container(
                  width: 200,
                  height: 10,
                  child: const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: 0,
                      valueColor: AlwaysStoppedAnimation<Color>(constants.yellow),
                      backgroundColor: constants.grey,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                    width: 20,
                    height: 30,
                    child: Image.asset("assets/images/ic_awesome_icon.PNG")),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 40,),
                Text("Good" ,  style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: Colors.grey),) ,
                SizedBox(width: 65,),
                Container(
                  width: 200,
                  height: 10,
                  child: const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: 0,
                      valueColor: AlwaysStoppedAnimation<Color>(constants.yellow),
                      backgroundColor: constants.grey,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                    width: 20,
                    height: 30,
                    child: Image.asset("assets/images/ic_great_rate.PNG")),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 40,),
                Text("Meh" ,  style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: Colors.grey),) ,
                SizedBox(width: 70,),
                Container(
                  width: 200,
                  height: 10,
                  child: const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: 0,
                      valueColor: AlwaysStoppedAnimation<Color>(constants.yellow),
                      backgroundColor: constants.grey,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                    width: 20,
                    height: 30,
                    child: Image.asset("assets/images/ic_meh_rate.PNG")),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 40,),
                Text("Bad" ,  style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: Colors.grey),) ,
                SizedBox(width: 73,),
                Container(
                  width: 200,
                  height: 10,
                  child: const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: 0,
                      valueColor: AlwaysStoppedAnimation<Color>(constants.yellow),
                      backgroundColor: constants.grey,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                    width: 20,
                    height: 30,
                    child: Image.asset("assets/images/ic_bad_rate.PNG")),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 40,),
                Text("Very Bad" ,  style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: Colors.grey),) ,
                SizedBox(width: 46,),
                Container(
                  width: 200,
                  height: 10,
                  child: const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: 0,
                      valueColor: AlwaysStoppedAnimation<Color>(constants.yellow),
                      backgroundColor: constants.grey,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                    width: 20,
                    height: 30,
                    child: Image.asset("assets/images/ic_bad_rate.PNG")),
              ],
            ),
            Container(
                width: 180,
                height: 180,
                child: Image.asset("assets/images/ic_comments.PNG")),
            Text("You don't have any reviews yet" ,  style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: Colors.black),) ,
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0 , right: 20.0),
              child: Text("Don't worry , Once You Start Accepting Bookings , The Reviews Will Start Showing! We Can't Wait" ,  style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: Colors.grey),),
            ) ,
          ],
        ),
      ),
    ));
  }
}
