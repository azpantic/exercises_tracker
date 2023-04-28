import 'package:flutter_mobile_application_template/models/exercise.dart';
import 'package:get/get.dart';

import '../../models/workout.dart';

class WorkoutAPI extends GetConnect {
  Future<WorkoutData> getWokroutDataById(int id) async {
    await Future.delayed(Duration(milliseconds: 500));

    return WorkoutData(id: id, name: "name1", date: DateTime.now(), exercises: [
      Exercise(id: 1, name: "name1", repeats: []),
      Exercise(id: 1, name: "name1", repeats: []),
      Exercise(id: 1, name: "name1", repeats: []),
    ]);
  }

  Future<List<String>> getExerciseNames() async {
    return [
      "name5",
      "name6",
      "name7",
      "name1",
    ];
  }
}

WorkoutAPI workoutAPI = WorkoutAPI();

class WorkoutController extends GetxController {
  RxBool isLoading = true.obs;

  WorkoutData workoutData =
      WorkoutData(id: -1, name: "undefine", date: DateTime.now(), exercises: []);

  RxList<Exercise> exercises = <Exercise>[].obs;

  RxList<String> avalibleExerciseNames = <String>[].obs;

  int workoutId = -1;

  Future<void> setWorkoutId(int newWorkourId) async {
    isLoading(true);

    workoutId = newWorkourId;

    workoutData = await workoutAPI.getWokroutDataById(workoutId);
    exercises(workoutData.exercises);

    List<String> allExerciseNames = await workoutAPI.getExerciseNames();
    List<String> filteredExerciseNamse = allExerciseNames
        .where((name) => exercises().where((exercise) => exercise.name == name).isEmpty)
        .toList();

    avalibleExerciseNames(filteredExerciseNamse);

    isLoading(false);
  }

  Future<void> addNewExercise(String newExerciseName) async {
    exercises.add(Exercise(id: 1, name: newExerciseName, repeats: []));
    avalibleExerciseNames.remove(newExerciseName);
  }
}
