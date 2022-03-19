import 'package:get/get.dart';
import 'package:skep_home_pro/Dashboard/areaOfWork.dart';
import 'package:skep_home_pro/splash_screen/get_started.dart';
import 'package:skep_home_pro/splash_screen/splash_screen.dart';
import 'package:skep_home_pro/walkthrough/first_walk_through.dart';
import 'package:skep_home_pro/walkthrough/second_walk_through.dart';



class AppRoutes {
  static const welcome = Routes.welcomeScreen;
  static const mainScreen = Routes.first_walk_through;
  static const secondScreen = Routes.second_walk_through;

  static final routes = [
    GetPage(
      name: Routes.welcomeScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.first_walk_through,
      page: () => const first_walk_through(),
    ),
    GetPage(
      name: Routes.second_walk_through,
      page: () => const second_walk_through(),
    ),
    GetPage(
      name: Routes.get_started,
      page: () => const GetStarted(),
    ),
    GetPage(
        name: Routes.areaOfWork,
        page: () => const AreaOfWork(),
    ),

  ];

}

class Routes {
  static const welcomeScreen = '/welcomeScreen';
  static const first_walk_through = '/first_walk_through';
  static const second_walk_through = '/second_walk_through';
  static const get_started = '/get_started';
  static const areaOfWork = '/areaOfWork';

}