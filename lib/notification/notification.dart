import 'dart:async';
import 'dart:convert' show json;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

var deviceId;

abstract class IFCMNotificationService {
  Future<void> sendNotificationToUser({
    required String fcmToken,
    required String title,
    required String body,
  });

  Future<void> sendNotificationToGroup({
    required String group,
    required String title,
    required String body,
  });

  Future<void> unsubscribeFromTopic({
    required String topic,
  });

  Future<void> subscribeToTopic({
    required String topic,
  });
}

class FCMNotificationService extends IFCMNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final String _endpoint = 'https://fcm.googleapis.com/fcm/send';
  final String _contentType = 'application/json';
  final String _authorization =
      'Bearer AAAAWrUSJLU:APA91bGMWjDZU67HHzbEbXCJkjuG6-A4mtbL8ln6tupDglJEJuA-nCTejDC0qwaDTbFYwQyb37sb0jyPSG-c-wOxbJgjgWeQX-ebun9pP-vC4of_-Mu8D2eiZKDbbnY2VTLc3x56GZNk';


  Future<http.Response> _sendNotification(
      String to, String title, String body) async {
    try {
      final dynamic data = json.encode(
        {
          'to': to,
          'priority': 'high',
          'notification': {
            'title': title,
            'body': body,
          },
          'data' :{
            "title": title,
            "body": body,
            "sound": "default",
            "status": "done",
            "screen": "/chat",
            'click_action' : 'FLUTTER_NOTIFICATION_CLICK' ,
          },
          'content_available': true
        },
      );
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer AAAAWrUSJLU:APA91bGMWjDZU67HHzbEbXCJkjuG6-A4mtbL8ln6tupDglJEJuA-nCTejDC0qwaDTbFYwQyb37sb0jyPSG-c-wOxbJgjgWeQX-ebun9pP-vC4of_-Mu8D2eiZKDbbnY2VTLc3x56GZNk'
        },
      );



      print(response.statusCode);
      print(response.body);
      print("<<<<<<<<<>>>>>>>>> $to");

      return response;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> unsubscribeFromTopic({required String topic}) {
    return _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  @override
  Future<void> subscribeToTopic({required String topic}) {
    return _firebaseMessaging.subscribeToTopic(topic);
  }

  @override
  Future<void> sendNotificationToUser({
    required String fcmToken,
    required String title,
    required String body,
  })
  {
    print("<<<<<<<<<<<$fcmToken");
    return _sendNotification(fcmToken, title, body);
  }

  @override
  Future<void> sendNotificationToGroup(
      {required String group, required String title, required String body}) {
    return _sendNotification('/topics/' + group, title, body);
  }
}
