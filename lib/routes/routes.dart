import 'package:get/get.dart';
import 'package:skep_home_pro/Dashboard/Today\'s_Schedule.dart';
import 'package:skep_home_pro/Dashboard/areaOfWork.dart';
import 'package:skep_home_pro/MyBooking/complete_details.dart';
import 'package:skep_home_pro/Payment_Stripe/payment_stripe.dart';
import 'package:skep_home_pro/splash_screen/get_started.dart';
import 'package:skep_home_pro/splash_screen/splash_screen.dart';
import 'package:skep_home_pro/walkthrough/first_walk_through.dart';
import 'package:skep_home_pro/walkthrough/second_walk_through.dart';

import '../Back_ground_check/back_ground_check.dart';
import '../Dashboard/Dashboard.dart';
import '../Dashboard/TodaysList.dart';
import '../Dashboard/service_request_list.dart';
import '../MyBooking/schedule.dart';
import '../chatPage/chat.dart';
import '../controllers/complete_controller.dart';



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
    GetPage(
      name: Routes.dashboard,
      page: () => const Dashboard(),
    ),
    GetPage(
      name: Routes.chat,
      page: () =>  chatpage(email: "$EmailUser"),
    ),
    GetPage(
      name: Routes.serviceRequestList,
      page: () =>  const serviceRequestList(),
    ),
    GetPage(
      name: Routes.payment,
      page: () =>  const PaymentStripe(),
    ),
    // GetPage(
    //   name: Routes.bookingDetails,
    //   page: () =>  CompleteDetails(historyBooking: ,),
    // ),
  ];

}

class Routes {
  static const welcomeScreen = '/welcomeScreen';
  static const first_walk_through = '/first_walk_through';
  static const second_walk_through = '/second_walk_through';
  static const get_started = '/get_started';
  static const areaOfWork = '/areaOfWork';
  static const todaysSchedule = '/Today\'s_Schedule';
  static const dashboard = '/dashboard';
  static const chat = '/chat';
  static const serviceRequestList = '/serviceRequestList';
  static const payment = '/payment';
  static const bookingDetails = '/bookingDetails';
  static const settings = '/settings';

}