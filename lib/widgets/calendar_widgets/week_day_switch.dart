import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/calendar/weekday_switch_controller.dart';

class WeekdaySwitch extends StatelessWidget {
  WeekdaySwitch({
    super.key,
    required this.selectedDay,
    this.onDayChange,
    this.dateBuilder,
    this.showNavigationArrow = false,
  });

  bool showNavigationArrow;
  DateTime selectedDay;

  Widget Function(BuildContext context, DateTime day)? dateBuilder;
  void Function(DateTime selectedDay)? onDayChange;

  late final controller = Get.put(WeekdaySwitchController(selectedDay));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Text(
            
            controller
                .mountData()
                .map((mountData) =>
                    DateFormat.MMMM(Localizations.localeOf(context).toString())
                        .format(mountData))
                .join("-"),
            style: context.textTheme.headlineLarge)),
        SizedBox(
          height: 80,
          child: Row(
            children: [
              showNavigationArrow
                  ? IconButton(
                      onPressed: () => controller.weeksPageControl.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                      icon: const Icon(Icons.arrow_back_ios))
                  : Container(),

              // main day picker
              Expanded(
                child: PageView.builder(
                  controller: controller.weeksPageControl,
                  onPageChanged: (weekIndex) =>
                      controller.setSelectedWeekIndex(weekIndex),
                  itemBuilder: (ctx, weekIndex) {
                    // controller.setSelectedWeekIndex(weekIndex);
                    return Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: createDaysCards(context),
                        ));
                  },
                ),
              ),

              showNavigationArrow
                  ? IconButton(
                      onPressed: () => controller.weeksPageControl.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                      icon: const Icon(Icons.arrow_forward_ios))
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> createDaysCards(BuildContext context) {
    return controller
        .selectedWeekDays()
        .map((day) => dateBuilder != null
            ? dateBuilder!(context, day)
            : defaultDateBuilder(context, day))
        .toList();
  }

  Widget defaultDateBuilder(BuildContext context, DateTime day) {
    return Expanded(
      child: Card(
        color: controller.selectedDay() == day
            ? context.theme.colorScheme.secondaryContainer
            : null,
        elevation: controller.selectedDay() == day ? 3 : 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            controller.setSelectedDay(day);
            onDayChange!(day);
          },
          child: SizedBox(
            height: 55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.E(Localizations.localeOf(context).toString())
                      .format(day),
                  style: context.textTheme.titleMedium,
                ),
                Text(day.day.toString())
              ],
            ),
          ),
        ),
      ),
    );
  }
}