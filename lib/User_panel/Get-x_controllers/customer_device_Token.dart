import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getCustomerDeviceToken() async {
  try {
 String? token = await FirebaseMessaging.instance.getToken();
     print('FCM Token: $token');
    return token;
    
    } catch (e) {
    print('Error getting FCM token: $e');
    throw Exception('Error getting FCM token');
  }
}
