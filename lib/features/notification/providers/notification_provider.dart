import 'package:flutter/material.dart';
import 'package:enjaz_user/common/models/api_response_model.dart';
import 'package:enjaz_user/features/notification/domain/models/notification_model.dart';
import 'package:enjaz_user/features/notification/domain/reposotories/notification_repo.dart';
import 'package:enjaz_user/helper/api_checker_helper.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepo? notificationRepo;
  NotificationProvider({required this.notificationRepo});

  List<NotificationModel>? _notificationList;
  List<NotificationModel>? get notificationList => _notificationList != null
      ? _notificationList!.reversed.toList()
      : _notificationList;

  Future<void> initNotificationList(BuildContext context) async {
    ApiResponseModel apiResponse =
        await notificationRepo!.getNotificationList();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _notificationList = [];
      apiResponse.response!.data.forEach((notificationModel) =>
          _notificationList!
              .add(NotificationModel.fromJson(notificationModel)));
      notifyListeners();
    } else {
      ApiCheckerHelper.checkApi(apiResponse);
    }
  }
}
