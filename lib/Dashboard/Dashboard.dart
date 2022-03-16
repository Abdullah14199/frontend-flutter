import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skep_home_pro/constatns/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int currentIndex = 0 ;



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon:  Image.asset("assets/images/ring.png"),
            onPressed: () {
              // do something
            },
          )
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Padding(
          padding: EdgeInsets.only(left: 70),
          child: Text("Service Request" , style: TextStyle(
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
          Padding(
            padding: const EdgeInsets.only(top: 130 , right: 52.6 , left: 52.6),
            child: Column(
              children: [
                Image.asset("assets/images/cleanerone.png"),
                const SizedBox(height: 20,),
                const Text("No Cleaning Jobs" , style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                ),),
                const SizedBox(height: 3,),
                const Center(
                  child:
                  Text("Sorry there Is no cleaning requests right now,",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Ubuntu',
                  ),),
                ),
                const Text("try refresh In a while.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Ubuntu',
                  ),),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    width: 180,
                    height: 45,
                    decoration: const BoxDecoration(
                        color: constants.yellow,
                        borderRadius: BorderRadius.all(Radius.circular(18))
                    ),
                    child: const Center(
                      child: Text("Get Started" ,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ubuntu' ,
                        ),),
                    ),
                  ),
                ),
              ],
            ),
          )
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
}
