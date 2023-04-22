import 'package:flutter/material.dart';
import 'package:flutter_mobile_application_template/constans.dart';
import 'package:flutter_mobile_application_template/controllers/calendar/calendar_controller.dart';
import 'package:flutter_mobile_application_template/i18n/strings.g.dart';
import 'package:flutter_mobile_application_template/widgets/calendar_widgets/week_day_switch.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../models/workout.dart';

class CalendarPage extends GetView<CalendarController> {
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
      floatingActionButton: ElevatedButton(
        child: Text(t.calendar.add_workout),
        onPressed: () {},
      ),
    );
  }
}

class WorkoutList extends GetView<CalendarController> {
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
            child: ListView(
              children: controller
                  .selectedDayWorkouts()
                  .map((workout) => WorkoutTile(workoutData: workout))
                  .toList(),
            ),
          );
        },
      );
}

class WorkoutTile extends StatelessWidget {
  WorkoutTile({super.key, required this.workoutData});

  Workout workoutData;
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
        trailing: const Icon(Icons.arrow_right),
        onTap: () {},
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
