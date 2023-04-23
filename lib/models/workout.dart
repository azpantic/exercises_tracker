
import 'package:flutter_mobile_application_template/models/exercise.dart';

class WorkoutListItem{

  WorkoutListItem({required this.id , required this.name, required this.date , required this.exerciseCount});

  int id;
  DateTime date;
  String name;
  int exerciseCount;
}

class WorkoutData{

  WorkoutData({ required this.id , required this.date , required this.name , required this.exercises });

  int id;

  DateTime date;
  String name;

  List<Exercise> exercises;

}