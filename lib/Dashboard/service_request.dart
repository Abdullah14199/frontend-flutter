import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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


  PickedFile ? _imageFile;
  final String uploadUrl = 'http://staging.skephome.com/api/User/UpdateProfile';
  final ImagePicker _picker = ImagePicker();

  Future<String?> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    var res = await request.send();
    return res.reasonPhrase;
  }

  Future<void> retriveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      print('Retrieve error ' + response.exception!.code);
    }
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.camera);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
    }
  }

  late File _file;
  Future pickCamera() async{
    final myFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _file = File(myFile!.path);
      if(_file == null ) return ;
      String base64 = base64Encode(_file.readAsBytesSync());
      String imageName = _file.path.split("/").last ;

      //_futureAlbum = Upload(_file);

    });
  }


  // Upload(File image) async {
  //   // final response = await http.post(
  //   //     Uri.parse('http://staging.skephome.com/api/User/UpdateProfile'),
  //   //     headers: {
  //   //       HttpHeaders.authorizationHeader : 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1MSIsImp0aSI6IjYzOGQ4Y2RmZmQzMGQ0MTQ4MDI3OTc0OGMyZDJiMmVmZTU4MmU5ODYxZDhhZTEwOTlmOWI3YzQ0OWRmNmIwYTk5ZmU1M2E3MDBkYWI1ZjQ4IiwiaWF0IjoxNjQ2NzM4MzM5LCJuYmYiOjE2NDY3MzgzMzksImV4cCI6MTY3ODI3NDMzOSwic3ViIjoiMjkiLCJzY29wZXMiOltdfQ.ZXO_CzXIBw6l2y64sl7waxlEfDqektgi_FZPqRGpCsNUmXVlVlM97YMDrmdXziD-VTrPAKwVi8dkWLnqx94Ov9PuAVLyO-s8xK2rRs8FExllhfa1u-LzXVdiJOjECZ1yutyICnWl4RYaROPGcUuojAkZR5xOYh-Q182YgFwlZlgZwH3WDAv8y2SixojnJ6oRlA4MSUCkpyfTiNuuhJ3NTf_MuUt-Md48thvkdpe5Jynags2CmpsacjHY6einZbvp74F_FdDHqA7ZDgn6HKrPdTyaBE2PiWQS5ujR54odwAZXzQfZ_zbioyGgmmjm-kkf2NeURNqvwha64nxg1TbmkH6v6xrjfghPOiOYMmWhOr2fQ6RKHS0Ck4CNtlwNDDywS1I0qR0mR2cmQgMrBth70LCSbG9PwtFrECRm2d6Vd2hxCxg8wHN3QHmDD6fApDzgqAVE1KSvFBcWO1qo9ZVCdBQ_9-C7GaiwMzb09hfW8QEd1RbABoqHgQzW97uzV7-_1bPCm5kUJcAAlPwpucUXqmU-iuBRf8BzTKS_8Lmp4-TNEEZx_VgeHLuTVoMEcV7I_DXswhjmY4leZrAefMIDparZbUhgTC5Aai1SDpX7qjTq1odQMi3fI3W_UgQT24GdxllKwg4gYJ0d92MBzLDOPAYSIgMVGKtT4Vo2SvFNUeE'
  //   //     });
  //   Map<String, String> headers = { "Bearer": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1MSIsImp0aSI6IjYzOGQ4Y2RmZmQzMGQ0MTQ4MDI3OTc0OGMyZDJiMmVmZTU4MmU5ODYxZDhhZTEwOTlmOWI3YzQ0OWRmNmIwYTk5ZmU1M2E3MDBkYWI1ZjQ4IiwiaWF0IjoxNjQ2NzM4MzM5LCJuYmYiOjE2NDY3MzgzMzksImV4cCI6MTY3ODI3NDMzOSwic3ViIjoiMjkiLCJzY29wZXMiOltdfQ.ZXO_CzXIBw6l2y64sl7waxlEfDqektgi_FZPqRGpCsNUmXVlVlM97YMDrmdXziD-VTrPAKwVi8dkWLnqx94Ov9PuAVLyO-s8xK2rRs8FExllhfa1u-LzXVdiJOjECZ1yutyICnWl4RYaROPGcUuojAkZR5xOYh-Q182YgFwlZlgZwH3WDAv8y2SixojnJ6oRlA4MSUCkpyfTiNuuhJ3NTf_MuUt-Md48thvkdpe5Jynags2CmpsacjHY6einZbvp74F_FdDHqA7ZDgn6HKrPdTyaBE2PiWQS5ujR54odwAZXzQfZ_zbioyGgmmjm-kkf2NeURNqvwha64nxg1TbmkH6v6xrjfghPOiOYMmWhOr2fQ6RKHS0Ck4CNtlwNDDywS1I0qR0mR2cmQgMrBth70LCSbG9PwtFrECRm2d6Vd2hxCxg8wHN3QHmDD6fApDzgqAVE1KSvFBcWO1qo9ZVCdBQ_9-C7GaiwMzb09hfW8QEd1RbABoqHgQzW97uzV7-_1bPCm5kUJcAAlPwpucUXqmU-iuBRf8BzTKS_8Lmp4-TNEEZx_VgeHLuTVoMEcV7I_DXswhjmY4leZrAefMIDparZbUhgTC5Aai1SDpX7qjTq1odQMi3fI3W_UgQT24GdxllKwg4gYJ0d92MBzLDOPAYSIgMVGKtT4Vo2SvFNUeE"};
  //
  //   var request = http.MultipartRequest("POST", Uri.parse('http://staging.skephome.com/api/User/UpdateProfile'));
  //   request.files.add(http.MultipartFile.fromBytes(
  //       "file",
  //       image.readAsBytesSync(),
  //       contentType: MediaType('selfie', 'png'))
  //   );
  //   request.headers.addAll(headers);
  //
  //   var response2 = await request.send();
  //   print(response2.statusCode);
  //   response2.stream.transform(utf8.decoder).listen((value) {
  //     print(value);
  //   });
  // }



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
        body: Stack(
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
                _pickImage();
                //_futureAlbum = createAlbum(image);
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
                    value: 0.7,
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

