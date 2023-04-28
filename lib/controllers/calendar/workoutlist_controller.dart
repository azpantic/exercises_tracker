import 'dart:io';

import 'package:flutter_mobile_application_template/models/workout.dart';
import 'package:get/get.dart';

class WorkoutListAPI extends GetConnect {
  Future<List<WorkoutListItem>> getWorkoutListOnSetectedDay(
      DateTime selectedDay) async {
    await Future.delayed(Duration(milliseconds: 1));
    return [
      WorkoutListItem(
          id: 1, name: "name1", date: selectedDay, exerciseCount: 2),
      WorkoutListItem(
          id: 2, name: "name2", date: selectedDay, exerciseCount: 3),
      WorkoutListItem(
          id: 3, name: "name3", date: selectedDay, exerciseCount: 4),
      WorkoutListItem(
          id: 4, name: "name4", date: selectedDay, exerciseCount: 5),
    ];
  }

  Future<List<String>> getAllWorkoutNames() async {
    return [
      "name5",
      "name6",
      "name7",
      "name1",
    ];
  }
}

WorkoutListAPI workoutListAPI = WorkoutListAPI();

class WorkoutListController extends GetxController {
  Map<DateTime, List<WorkoutListItem>> workoutData = {};

  Rx<DateTime> selectedDay = DateTime.now().obs;

  RxList<WorkoutListItem> selectedDayWorkouts = <WorkoutListItem>[].obs;
  RxList<String> avalibleWorkoutNames = <String>[].obs;

  RxBool isLoading = true.obs;

  Future<void> setSelectedDay(DateTime newSelectedDay) async {
    isLoading(true);

    DateTime newDate =
        DateTime(newSelectedDay.year, newSelectedDay.month, newSelectedDay.day);
    selectedDay(newDate);

    selectedDayWorkouts(
        await workoutListAPI.getWorkoutListOnSetectedDay(newSelectedDay));

    List<String> allWorkoutNames = await workoutListAPI.getAllWorkoutNames();

    List<String> filteredWorkoutNamse = allWorkoutNames
        .where((name) =>
            selectedDayWorkouts()
                .where((workout) => workout.name == name).isEmpty)
        .toList();

    avalibleWorkoutNames(filteredWorkoutNamse);

    isLoading(false);
  }

  Future<void> addNewWorkout(String workoutName) async {

    // isLoading(true);

    selectedDayWorkouts.add(WorkoutListItem(
        id: 5, name: workoutName, date: selectedDay(), exerciseCount: 0));
    avalibleWorkoutNames.remove(workoutName);
  
    
    // isLoading(false);
  }

  Future<void> deleteWorkout(int workoutId) async {

    selectedDayWorkouts.removeWhere( (workout) => workout.id == workoutId);

  }

}
