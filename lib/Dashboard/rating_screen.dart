import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/controllers/rating_controller.dart';

class ratingScreen extends StatefulWidget {
  const ratingScreen({Key? key}) : super(key: key);

  @override
  State<ratingScreen> createState() => _ratingScreenState();
}

class _ratingScreenState extends State<ratingScreen> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<RatingController>(
          init: RatingController(),
          builder: (controller){
            print(controller.cleanerRatingList.isEmpty);
            return Scaffold(
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
              body: ConditionalBuilder(
                builder: (context) => Center(
                  child: Column(
                    children: [
                      Text("Client Reviews" , style: TextStyle(fontSize: 16 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold),),
                      Container(
                          width: 40,
                          height: 60,
                          child: Level_statues == "Awesome" ? Image.asset("assets/images/ic_colored_awesome.PNG") :
                          Level_statues == "Great" ? Image.asset("assets/images/ic_colored_great.PNG") :
                          Level_statues == "Good" ? Image.asset("assets/images/ic_colored_good.PNG") :
                          Level_statues == "Meh" ? Image.asset("assets/images/ic_colored_meh.PNG") :
                          Level_statues == "Bad" ? Image.asset("assets/images/ic_colored_bad.PNG") : Image.asset("assets/images/ic_great_rate.PNG")),
                      Text(controller.cleanerRatingList.isEmpty ?"No Customer Ratings" : "${controller.cleanerRatingList.length} Customer Ratings" , style: TextStyle(fontSize: 11 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: Colors.grey),),
                      SizedBox(height: 7,),
                      Row(
                        children: [
                          SizedBox(width: 40,),
                          Text("Awesome" ,  style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: constants.dark_green),) ,
                          SizedBox(width: 40,),
                          Container(
                            width: 200,
                            height: 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                value: controller.ratingModel!.ratingCount.awesome.toDouble() / 50,
                                valueColor: AlwaysStoppedAnimation<Color>(constants.dark_green),
                                backgroundColor: constants.grey,
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                              width: 20,
                              height: 30,
                              child: Image.asset("assets/images/ic_colored_awesome.PNG")),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 40,),
                          Text("Great" ,  style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: constants.great_color),) ,
                          SizedBox(width: 63,),
                          Container(
                            width: 200,
                            height: 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                value: controller.ratingModel!.ratingCount.great.toDouble() / 50,
                                valueColor: AlwaysStoppedAnimation<Color>(constants.great_color),
                                backgroundColor: constants.grey,
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                              width: 20,
                              height: 30,
                              child: Image.asset("assets/images/ic_colored_great.PNG")),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 40,),
                          Text("Good" ,  style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: constants.good_color),) ,
                          SizedBox(width: 65,),
                          Container(
                            width: 200,
                            height: 10,
                            child:  ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                value: controller.ratingModel!.ratingCount.good.toDouble() / 50,
                                valueColor: AlwaysStoppedAnimation<Color>(constants.good_color),
                                backgroundColor: constants.grey,
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                              width: 20,
                              height: 30,
                              child: Image.asset("assets/images/ic_colored_good.PNG")),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 40,),
                          Text("Meh" ,  style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: constants.meh_color),) ,
                          SizedBox(width: 70,),
                          Container(
                            width: 200,
                            height: 10,
                            child:  ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                value: controller.ratingModel!.ratingCount.meh.toDouble() / 50,
                                valueColor: AlwaysStoppedAnimation<Color>(constants.meh_color),
                                backgroundColor: constants.grey,
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                              width: 20,
                              height: 30,
                              child: Image.asset("assets/images/ic_colored_meh.PNG")),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 40,),
                          Text("Bad" ,  style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: constants.bad_color),) ,
                          SizedBox(width: 73,),
                          Container(
                            width: 200,
                            height: 10,
                            child:  ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                value: controller.ratingModel!.ratingCount.bad.toDouble() / 50,
                                valueColor: AlwaysStoppedAnimation<Color>(constants.bad_color),
                                backgroundColor: constants.grey,
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                              width: 20,
                              height: 30,
                              child: Image.asset("assets/images/ic_colored_bad.PNG")),
                        ],
                      ),
                      controller.cleanerRatingList.isEmpty ? Container(
                          width: 180,
                          height: 180,
                          child: Image.asset("assets/images/ic_comments.PNG")) :
                      ListView.builder(
                        itemCount: controller.cleanerRatingList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  padding: EdgeInsets.only(
                                    left: 3,
                                    right: 0,
                                    top: 2,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 370,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0 , left: 25.0),
                                                    child: Text(
                                                      controller.cleanerRatingList[index].rate == 5 ? "Awesome" :
                                                      controller.cleanerRatingList[index].rate == 4 ? "Great" :
                                                      controller.cleanerRatingList[index].rate == 3 ? "Good" :
                                                      controller.cleanerRatingList[index].rate == 2 ? "Meh" :
                                                      controller.cleanerRatingList[index].rate == 1 ? "Bad" : "",
                                                      style: TextStyle(
                                                          color:controller.cleanerRatingList[index].rate == 5 ? constants.dark_green :
                                                          controller.cleanerRatingList[index].rate == 4 ? constants.great_color:
                                                          controller.cleanerRatingList[index].rate == 3 ? constants.good_color:
                                                          controller.cleanerRatingList[index].rate == 2 ? constants.meh_color:
                                                          controller.cleanerRatingList[index].rate == 1 ? constants.bad_color: Colors.white,
                                                          fontSize: 12,
                                                          fontFamily: 'Ubuntu',
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0 ),
                                                    child: Text(
                                                      "${controller.cleanerRatingList[index].date}",
                                                      style: TextStyle(
                                                          color: constants.grey,
                                                          fontSize: 12,
                                                          fontFamily: 'Ubuntu',
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 25.0 ,),
                                              child: Text(
                                                controller.cleanerRatingList[index].comment,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontFamily: 'Ubuntu',
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                               ),
                      ),
                      controller.cleanerRatingList.isEmpty ?
                      Text("You don't have any reviews yet" ,  style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: Colors.black), ) : SizedBox(),
                      SizedBox(height: 10,),
                      controller.cleanerRatingList.isEmpty ?
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0 , right: 20.0),
                        child: Text("Don't worry , Once You Start Accepting Bookings , The Reviews Will Start Showing! We Can't Wait" ,  style: TextStyle(fontSize: 12 , fontFamily: 'Ubuntu' , fontWeight: FontWeight.bold , color: Colors.grey),),
                      ) : SizedBox() ,
                    ],
                  ),
                ),
                condition: controller.isLoading,
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
            );
          },

        ));
  }
}
