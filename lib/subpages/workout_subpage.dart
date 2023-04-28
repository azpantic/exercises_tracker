import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_mobile_application_template/controllers/calendar/workout_controller.dart';
import 'package:flutter_mobile_application_template/models/exercise.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import 'package:intl/intl.dart';

import '../constans.dart';

class WorkoutSubpage extends GetView<WorkoutController> {
  WorkoutSubpage({super.key, required this.workoutId}) {
    controller.setWorkoutId(workoutId);
  }

  int workoutId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBuilder(context),
      body: Obx(
        () {
          if (controller.isLoading()) {
            return Center(
              child: LoadingAnimationWidget.twoRotatingArc(
                color: Theme.of(context).colorScheme.primary.withAlpha(128),
                size: context.mediaQueryShortestSide / 4,
              ),
            );
          }

          return ExerciseList();
        },
      ),
      floatingActionButton: Obx(
        () => ElevatedButton(
          child: Text("Добавить упражнение"),
          onPressed: (controller.isLoading() ? null : () => showExerciseNames(context)),
        ),
      ),
    );
  }

  AppBar appBarBuilder(BuildContext context) {
    return AppBar(
      title: Obx(
        () {
          if (controller.isLoading()) {
            return ShimmerEffect(
              baseColor: context.theme.colorScheme.background,
              highlightColor: context.theme.colorScheme.onBackground,
              child: Text(
                "Loading...",
              ),
            );
          }

          String formatDate = DateFormat.MMMEd(Localizations.localeOf(context).toString())
              .format(controller.workoutData.date);

          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                "${controller.workoutData.name} $formatDate",
                overflow: TextOverflow.ellipsis,
              ));
        },
      ),
    );
  }

  void showExerciseNames(BuildContext context) {
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
                  "Выбирете вид упражнения",
                  style: context.textTheme.titleLarge,
                ),
                Expanded(
                  child: Obx(
                    () => ListView(
                      children: controller
                          .avalibleExerciseNames()
                          .map(
                            (exerciseName) => ListTile(
                              title: Text(exerciseName),
                              trailing: Icon(Icons.add),
                              onTap: () {
                                controller.addNewExercise(exerciseName);
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

class ExerciseList extends GetView<WorkoutController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          children: controller
              .exercises()
              .map((exercise) => ExerciseTile(
                    exerciseData: exercise,
                  ))
              .toList(),
        ));
  }
}

class ExerciseTile extends StatelessWidget {
  ExerciseTile({super.key, required this.exerciseData});

  Exercise exerciseData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(appRoundRadius),
        ),
        title: Text(exerciseData.name),
        subtitle: Text("${exerciseData.repeats.length} подходов"),
        trailing: Icon(Icons.edit_note),
        onTap: () => showExerciseData(context),
      ),
    );
  }

  showExerciseData(BuildContext context) {
    TextEditingController repsController = TextEditingController();

    Dialog dialog = Dialog(
      child: SizedBox(
        width: context.width * 0.8,
        height: context.height * 0.7,
        child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(appPadding),
                child: Text("Подходы"),
              ),

              Divider(),

              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [], 
                  ),
                ),
              ),

              Divider(),

              // Add reps btb and field
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: context.height * 0.1),
                child: Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      // Text filed for weight and reps
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r"^[0-9]+$")),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(helperText: "Повторы"),
                            ),
                          ),
                          VerticalDivider(),
                          Expanded(
                            child: TextField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r"^[0-9]+$")),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(helperText: "Вес"),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(appPadding),
                        child: ElevatedButton(onPressed: () {}, child: Text("Добваить подход")),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

    showDialog(context: context, builder: (context) => dialog);
  }
}
