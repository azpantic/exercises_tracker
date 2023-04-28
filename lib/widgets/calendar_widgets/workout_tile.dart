// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../constans.dart';
import '../../controllers/calendar/workoutlist_controller.dart';
import '../../models/workout.dart';


class WorkoutTile extends StatefulWidget {
  WorkoutTile({super.key, required this.workoutData});

  WorkoutListItem workoutData;

  @override
  State<WorkoutTile> createState() => _WorkoutTileState();
}

class _WorkoutTileState extends State<WorkoutTile> {
  WorkoutListController controller = Get.find<WorkoutListController>();

  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(milliseconds: 200),
        ()=> setState(() {
              opacity = 1;
            }));
    return AnimatedOpacity(
        opacity: opacity,
        duration: Duration(milliseconds: 500),
        child: workoutTileBuilder(context));
  }

  Padding workoutTileBuilder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(appRoundRadius),
        ),
        title: Text(widget.workoutData.name),
        subtitle:
            Text("Кол-во Упражнений : ${widget.workoutData.exerciseCount}"),
        trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              AlertDialog alert = AlertDialog(
                title: Text("Удалить"),
                content: Text(
                    "Вы уверены что хотите удалить терировку ${widget.workoutData.name} ?"),
                actions: [
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: Text("Отмена"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.deleteWorkout(widget.workoutData.id);
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
              extra: {"workoutId": widget.workoutData.id.toString()});
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
