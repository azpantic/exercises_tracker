import 'dart:io';

import 'package:flutter_mobile_application_template/models/workout.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  Map<DateTime, List<Workout>> workoutData = {};

  Rx<DateTime> selectedDay = DateTime.now().obs;

  RxList<Workout> selectedDayWorkouts = <Workout>[].obs;

  RxBool isLoading = true.obs;

  Future<void> setSelectedDay(DateTime newSelectedDay) async {
    
    isLoading(true);

    DateTime newDate =
        DateTime(newSelectedDay.year, newSelectedDay.month, newSelectedDay.day);
    selectedDay(newDate);

    await Future.delayed( Duration(seconds: 3));

    selectedDayWorkouts([
      Workout(id: 1, name: "name1", exerciseCount: 2),
      Workout(id: 2, name: "name2", exerciseCount: 3),
      Workout(id: 3, name: "name3", exerciseCount: 4),
      Workout(id: 4, name: "name4", exerciseCount: 5),
    ]);

    isLoading(false);
  }
}
