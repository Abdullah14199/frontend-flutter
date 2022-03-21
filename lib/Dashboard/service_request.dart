import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skep_home_pro/Back_ground_check/back_ground_check.dart';
import 'package:skep_home_pro/Dashboard/areaOfWork.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/models/updateProfileApi.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class service_request extends StatefulWidget {

  @override
  State<service_request> createState() => _service_requestState();
}



class _service_requestState extends State<service_request> {

  double _value = 0.5;
  int currentIndex = 0 ;
  PageController _pageController = PageController();

  Future<userProfileModel>? _futureAlbum;

  File ? _file;
  Future pickCamera() async{
    final myFile = await ImagePicker().getImage(source: ImageSource.camera , imageQuality: 60);
    setState(() {
      _file = File(myFile!.path);
      if(_file == null ) return ;
      _futureAlbum = editUserData(_file);
    });
  }

  static Future<userProfileModel> editUserData(File? image) async {
    String basicAuth = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1MSIsImp0aSI6ImUxM2YzYmVjZWFjMzc0NDcwZTA2ODNkZDVmYWZmOWJkYzkzMmZmZWE3MjY2YmE1NDI5MDUwMDM0NzRlM2JhOWNmNGM3ZGM2NzIzZDZjNjFhIiwiaWF0IjoxNjQ3MzQ4NDQ4LCJuYmYiOjE2NDczNDg0NDgsImV4cCI6MTY3ODg4NDQ0OCwic3ViIjoiNTYiLCJzY29wZXMiOltdfQ.oUr1WS1-YuWrF9VdPOsJmRMCRxZVtULJSpVRDC_cM7CjpkIztzEB2mQCt9EMvWTwj_cr6r-UYiU-S4dnOS-GaK6FV2KInbM-23Nv-tOYj8Th19_qwpRgzEJWlukv2R-05vA7FDegRJ0L4jEtfycBSDqNd6KEXaULqiYvjHuCaO0nRnyp1_QWU-5Uan0Od7vdPQ6uYLd_ecP1oYtoF1gnzPq7dkbaVHkGwDCd8NIyVBvnDxr3PLkjU6RhazptZD7zDu65-ItIlEr_0NHVqOh78MpHRoPFag531OYQIPMj8NjNdw8SRdpZnr2Rxt-XdV1pfJrzvfsZZ1oG2ydyrwnkTQqiqwPYyxsT6UlElvlXMwA9XCpzzro16W1V66paDgrv5Fp0-Ev1IngnlZhfEduEkVUA2hWd68q-a0yl6j_8s48Mcc3_nFf-HD2cyIpbkNVPJww8YJ18mxR0s-fwGdke6wq2yPCnTwqLZcjSjb_jED6IMNgY_tSUX9v5Bq1dGYm5IxtQ039suJj53YpTikSawj8-UPrj3rPjnvaHpdvChsb3Ln2zaBJXew5QEgJBX7KlRIUTn2hIXL5lEkJbfB5TbZNzK5bw5sfNQLbU4yI2nWtpMTBfscCIMB-sp9x9JM1MQQw_dLNwiJA2jCTXzFjKeExG3G8mp8OmbEEO8vrcz6Q';
    var uri = Uri.parse("http://staging.skephome.com/api/User/UpdateProfile");
    var request =  http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = basicAuth;

    image != null ? request.files.add(await http.MultipartFile.fromPath('selfie', image.path)) : request.fields['selfie'];
    http.Response response = await http.Response.fromStream(await request.send());
    return userProfileModel.fromJson(JsonDecoder().convert(utf8.decode(response.bodyBytes)));
  }


  @override
    Widget build(BuildContext context) {
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
          title: const Padding(
            padding: EdgeInsets.only(left: 70),
            child: Text("Request Details" , style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
            ),),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.black,
          child: ListView(
            children: const <Widget>[
              UserAccountsDrawerHeader(accountName: Text("Abdullah Mohy"), accountEmail: Text("Abdullah.m@skephome.com"))
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Positioned(
                    left: 60,
                      child: Image.asset("assets/images/service_request.png")
                  ),
                  const Positioned(
                    top: 280,
                    left: 40,
                    right: 40,
                    child: Center(
                      child: Text(
                        "Skep Pro Services helps you find the best.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),),
                  const Positioned(
                    top: 298,
                    left: 60,
                    right: 60,
                    child: Center(
                      child: Text(
                        "cleaning job opportunities near you by",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),),
                  const Positioned(
                    top: 316,
                    left: 60,
                    right: 60,
                    child: Center(
                      child: Text(
                        "connecting you to local homeowners.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70,),
                  Positioned(
                    right: 14,
                    left: 14,
                    child: Container(
                      width: double.infinity,
                      height: 280,
                      child: PageView(
                        controller: _pageController,
                        children: [
                          _backgroundCheck('Background check' , Colors.white),
                          _page('Profile Picture' , Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                  top: 680,
                  left: 350,
                  right: 15,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 2,
                    effect: WormEffect(),
                    onDotClicked: (index) => _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.bounceOut),
                  ))
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/home.png")),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/nosBottomNavigationBar.png")),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/dashboard.png")),
              label: '',
            ),
          ],
          // currentIndex: _selectedIndex,
          selectedItemColor: constants.blue2,
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
        ),
      ),
    );
  }

  _page(String s, Color color) {
    return Container(
      color: color,
      child: Stack(
          children:[
          Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            height: 3,
            color: constants.grey,
          )),
      Positioned(
        top: 15,
        left: 15,
        right: 15,
        child: Text(s ,
          style:
          const TextStyle(
              color: Colors.black ,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu' ,
              fontSize: 14),
        ),
      ),
      Positioned(
          top: 15,
          left: 300,
          right: 20,
          child: ElevatedButton(
            child: const Text("Upload Now" ,textAlign: TextAlign.center ,style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu',
            )),
            onPressed: (){
              setState(() {
               pickCamera();
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(constants.blue2),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                      borderRadius:  BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),bottomRight: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                      side: BorderSide(color: constants.blue2)
                  )
              ),
            ),
          ),
      ),
      const Positioned(
        top: 36,
        left: 15,
        right: 15,
        child: Text("Take a real profile picture" ,
          style:
          TextStyle(
              color: constants.blue2 ,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu' ,
              fontSize: 14),
        ),
      ),
      const Positioned(
        top: 70,
        left: 15,
        right: 15,
        child: Text("Your photo will make it easier for homeowners to Recognize you." ,
          style:
          TextStyle(
              color: constants.grey ,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ubuntu' ,
              fontSize: 14),
        ),
      ),
            const Positioned(
                top: 257,
                right: 30,
                left: 320,
                child: Text("2/2" , style: TextStyle(
                  fontSize: 14 ,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.normal,
                ),))
          ]
      )
    );
}

  _backgroundCheck(String s, Color color) {
    return Container(
      color: color,
      child: Stack(
        children:[
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 3,
                color: constants.grey,
              )),
          Positioned(
            top: 15,
            left: 15,
            right: 15,
            child: Text(s ,
              style:
              const TextStyle(
                  color: Colors.black ,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu' ,
                  fontSize: 14),
            ),
          ),
          Positioned(
            top: 15,
            left: 250,
            right: 15,
            child: ElevatedButton(
              child: Text("Complete Now"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => backGroundCheck()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(constants.blue2),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius:  BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),bottomRight: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                        side: BorderSide(color: constants.blue2)
                    )
                ),
              ),
            )
          ),
          const Positioned(
            top: 36,
            left: 15,
            right: 15,
            child: Text("3 steps left" ,
              style:
              TextStyle(
                  color: constants.blue2 ,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu' ,
                  fontSize: 14),
            ),
          ),
          Positioned(
              top: 70,
              left:15 ,
              right: 15,
              child: Container(
                width: 40,
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
          ),
          const Positioned(
            top: 90,
            left: 15,
            right: 15,
            child: Text("You’ll have to complete this and be approved before starting Receiving new jobs. " ,
              style:
              TextStyle(
                  color: constants.grey ,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu' ,
                  fontSize: 14),
            ),
          ),
          Positioned(
              top: 140,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 3,
                color: constants.grey,
              )),
          Positioned(
            top: 160,
            left: 15,
            right: 15,
            child: Text("Area of work" ,
              style:
              const TextStyle(
                  color: Colors.black ,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu' ,
                  fontSize: 14),
            ),
          ),
          Positioned(
              top: 160,
              left: 280,
              right: 15,
              child: ElevatedButton(
                child: Text("Set Now"),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AreaOfWork()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(constants.blue2),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                          borderRadius:  BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),bottomRight: Radius.circular(10) , bottomLeft: Radius.circular(10)),
                          side: BorderSide(color: constants.blue2)
                      )
                  ),
                ),
              )
          ),
          const Positioned(
            top: 181,
            left: 15,
            right: 15,
            child: Text("Select multiple working areas" ,
              style:
              TextStyle(
                  color: constants.blue2 ,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu' ,
                  fontSize: 14),
            ),
          ),
          const Positioned(
            top: 215,
            left: 15,
            right: 15,
            child: Text("We will help you with finding the best working opportunities In your selected working areas" ,
              style:
              TextStyle(
                  color: constants.grey ,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu' ,
                  fontSize: 14),
            ),
          ),
          const Positioned(
              top: 257,
              right: 30,
              left: 320,
              child: Text("1/2" , style: TextStyle(
                fontSize: 14 ,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.normal,
              ),))

        ] ,
      ),
    );
  }
}

