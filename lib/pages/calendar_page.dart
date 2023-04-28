import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_application_template/constans.dart';
import 'package:flutter_mobile_application_template/i18n/strings.g.dart';
import 'package:flutter_mobile_application_template/widgets/calendar_widgets/week_day_switch.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/calendar/workoutlist_controller.dart';
import '../models/workout.dart';
import '../widgets/calendar_widgets/workout_tile.dart';

class CalendarPage extends GetView<WorkoutListController> {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.navbar.calendar),
      ),
      body: Column(
        children: [
          // WeekDay Switcher
          Padding(
            padding: const EdgeInsets.only(left: appPadding, right: appPadding),
            child: WeekdaySwitch(
              selectedDay: DateTime.now(),
              onDayChange: (selectedDay) async {
                controller.setSelectedDay(selectedDay);
              },
            ),
          ),

          // Divider
          const Padding(
            padding: EdgeInsets.all(appPadding),
            child: Divider(thickness: 1),
          ),

          WorkoutList(),
        ],
      ),
      floatingActionButton: Obx(
        () => ElevatedButton(
          child: Text(t.calendar.add_workout),
          onPressed: (controller.isLoading() ? null : () => showAvalibleWorkoutNames(context)),
        ),
      ),
    );
  }

  void showAvalibleWorkoutNames(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 1,
        expand: true,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.all(appPadding * 2),
            child: Column(
              children: [
                Text(
                  "Выбирете вид тернировки",
                  style: context.textTheme.titleLarge,
                ),
                Expanded(
                  child: Obx(
                    () => ListView(
                      children: controller
                          .avalibleWorkoutNames()
                          .map(
                            (workoutName) => ListTile(
                              title: Text(workoutName),
                              trailing: Icon(Icons.add),
                              onTap: () {
                                controller.addNewWorkout(workoutName);
                                context.pop();
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class WorkoutList extends GetView<WorkoutListController> {
  const WorkoutList({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Obx(
        () {
          if (controller.isLoading()) {
            return Expanded(
              child: Center(
                child: LoadingAnimationWidget.twoRotatingArc(
                  color: Theme.of(context).colorScheme.primary.withAlpha(128),
                  size: context.mediaQueryShortestSide / 4,
                ),
              ),
            );
          }

          return Expanded(
            child: Obx(
              () => ListView(
                children: controller
                    .selectedDayWorkouts()
                    .map((workout) => WorkoutTile(workoutData: workout))
                    .toList(),
              ),
            ),
          );
        },
      );
}

class WorkoutTile extends GetView<WorkoutListController> {
  WorkoutTile({super.key, required this.workoutData});

  WorkoutListItem workoutData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(appRoundRadius),
        ),
        title: Text(workoutData.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Кол-во Упражнений : ${workoutData.exerciseCount}"),
          ],
        ),
        trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              AlertDialog alert = AlertDialog(
                title: Text("Удалить"),
                content: Text("Вы уверены что хотите удалить терировку ${workoutData.name} ?"),
                actions: [
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: Text("Отмена"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.deleteWorkout(workoutData.id);
                      context.pop();
                    },
                    child: Text("Да"),
                  ),
                ],
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }),
        onTap: () {
          context.push<Map<String, String>>("/calendar/workout_page",
              extra: {"workoutId": workoutData.id.toString()});
        },
      ),
    );

    // return Card(

    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(appRoundRadius)),
    //   child: InkResponse(
    //     borderRadius: BorderRadius.circular(appRoundRadius),
    //     onTap: () {

    //     },
    //     child: Center(child: Text(workoutName)),
    //   ),
    // );
  }
}
