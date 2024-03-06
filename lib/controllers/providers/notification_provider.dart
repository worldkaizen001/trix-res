
import 'package:restaurant/controllers/Helpers/notification_helper.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {

static dynamic unreadNoti;
  dynamic get unreadNote => unreadNoti;



Future<dynamic> unraad () async {

var unreadNoti =  NotificationHelper().allUnredNotification();
print("provider unread Notif $unreadNoti");

notifyListeners();


}

  
}