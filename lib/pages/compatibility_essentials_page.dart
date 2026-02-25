import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/global_state.dart';
import 'package:railmates/models/compatibility_model.dart';
import 'package:railmates/pages/compatibility_destinations_page.dart';

@NowaGenerated()
class CompatibilityEssentialsPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityEssentialsPage({super.key});

  @override
  State<CompatibilityEssentialsPage> createState() {
    return _CompatibilityEssentialsPageState();
  }
}

@NowaGenerated()
class _CompatibilityEssentialsPageState
    extends State<CompatibilityEssentialsPage> {
  DateTimeRange dates = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 30)),
  );

  RangeValues days = const RangeValues(7.0, 28.0);

  RangeValues mates = const RangeValues(2.0, 6.0);

  RangeValues budget = const RangeValues(400.0, 600.0);

  bool? visible = true;

  @override
  void initState() {
    visible = false;
    super.initState();
    SupabaseService().getUserCompatibility().then((value) {
      days = _fromInt4Range(value!.days!);
      mates = _fromInt4Range(value!.mates!);
      budget = _fromInt4Range(value!.budget!);
      dates = _fromDateRange(value!.dates!);
      visible = true;
      setState(() {});
    });
  }

  String _toDateRange(DateTimeRange range) {
    final start = range.start.toIso8601String().split('T').first;
    final end = range.end.toIso8601String().split('T').first;
    return '[${start},${end}]';
  }

  String _toInt4Range(RangeValues range) {
    return '[${range.start.toInt()},${range.end.toInt()}]';
  }

  DateTimeRange _fromDateRange(String rangeStr) {
    final parts = rangeStr.substring(1, rangeStr.length - 1).split(',');
    final start = DateTime.parse(parts[0]);
    final end = DateTime.parse(parts[1]);
    return DateTimeRange(start: start, end: end);
  }

  RangeValues _fromInt4Range(String rangeStr) {
    final parts = rangeStr.substring(1, rangeStr.length - 1).split(',');
    final start = double.parse(parts[0]);
    final end = double.parse(parts[1]);
    return RangeValues(start, end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.surface,
            ],
            begin: const AlignmentGeometry.xy(1.0, -1.0),
            end: const AlignmentGeometry.xy(1.0, 1.0),
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.only(
            top: 40.0,
            bottom: 40.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlexSizedBox(
                width: null,
                height: null,
                child: Text(
                  GlobalState.of(context).localizations.essentialInformation,
                  style: const TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                flex: 1,
                child: SingleChildScrollView(
                  child: Visibility(
                    visible: visible!,
                    replacement: const Align(
                      alignment: Alignment(0.0, 0.0),
                      child: CircularProgressIndicator(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30.0,
                        horizontal: 0.0,
                      ),
                      child: Column(
                        spacing: 30.0,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlexSizedBox(
                            width: 361.0,
                            height: 118.0,
                            child: Material(
                              elevation: 6.0,
                              borderRadius: BorderRadius.circular(8.0),
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerLow,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10.0,
                                  children: [
                                    Row(
                                      spacing: 10.0,
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                        Text(
                                          GlobalState.of(
                                            context,
                                          ).localizations.yourAvailability,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50.0,
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          await showDateRangePicker(
                                            context: context,
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now().add(
                                              const Duration(days: 365),
                                            ),
                                            anchorPoint: const Offset(0.0, 0.0),
                                          );
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.date_range),
                                        label: Text(
                                          '${dates.start.toString().split(' ').first} → ${dates.end.toString().split(' ').first}',
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll<Color?>(
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primaryContainer,
                                              ),
                                          foregroundColor:
                                              WidgetStatePropertyAll<Color?>(
                                                Theme.of(
                                                  context,
                                                ).colorScheme.onSurface,
                                              ),
                                          shadowColor:
                                              const WidgetStatePropertyAll<
                                                Color?
                                              >(null),
                                          elevation:
                                              const WidgetStatePropertyAll<
                                                double?
                                              >(null),
                                          side:
                                              const WidgetStatePropertyAll<
                                                BorderSide?
                                              >(null),
                                          shape:
                                              const WidgetStatePropertyAll<
                                                RoundedRectangleBorder?
                                              >(null),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          FlexSizedBox(
                            width: 361.0,
                            height: 136.0,
                            child: Material(
                              elevation: 6.0,
                              borderRadius: BorderRadius.circular(8.0),
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerLow,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 5.0,
                                  children: [
                                    Row(
                                      spacing: 10.0,
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                        Text(
                                          GlobalState.of(
                                            context,
                                          ).localizations.idealTripDuration,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${days.start.toInt()} - ${days.end.toInt()} jours',
                                    ),
                                    RangeSlider(
                                      values: days,
                                      min: 7.0,
                                      max: 28.0,
                                      divisions: 3,
                                      labels: RangeLabels(
                                        days.start.toInt().toString(),
                                        days.end.toInt().toString(),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          days = value;
                                        });
                                      },
                                      activeColor: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          FlexSizedBox(
                            width: 361.0,
                            height: 136.0,
                            child: Material(
                              elevation: 6.0,
                              borderRadius: BorderRadius.circular(8.0),
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerLow,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 5.0,
                                  children: [
                                    Row(
                                      spacing: 10.0,
                                      children: [
                                        Icon(
                                          Icons.people,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                        Text(
                                          GlobalState.of(
                                            context,
                                          ).localizations.numberOfMates,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${mates.start.toInt()} - ${mates.end.toInt()} personnes',
                                    ),
                                    RangeSlider(
                                      values: mates,
                                      min: 2.0,
                                      max: 6.0,
                                      divisions: 4,
                                      labels: RangeLabels(
                                        mates.start.toInt().toString(),
                                        mates.end.toInt().toString(),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          mates = value;
                                        });
                                      },
                                      activeColor: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          FlexSizedBox(
                            width: 361.0,
                            height: 136.0,
                            child: Material(
                              elevation: 6.0,
                              borderRadius: BorderRadius.circular(8.0),
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerLow,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 5.0,
                                  children: [
                                    Row(
                                      spacing: 10.0,
                                      children: [
                                        Icon(
                                          Icons.euro,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                        Text(
                                          GlobalState.of(
                                            context,
                                          ).localizations.budget,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${budget.start.toInt()}€ - ${budget.end.toInt()}€',
                                    ),
                                    RangeSlider(
                                      values: budget,
                                      min: 200.0,
                                      max: 800.0,
                                      divisions: 12,
                                      labels: RangeLabels(
                                        budget.start.toInt().toString(),
                                        budget.end.toInt().toString(),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          budget = value;
                                        });
                                      },
                                      activeColor: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              FlexSizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    SupabaseService()
                        .createCompatibility(
                          CompatibilityModel(
                            dates: _toDateRange(dates),
                            days: _toInt4Range(days),
                            mates: _toInt4Range(mates),
                            budget: _toInt4Range(budget),
                          ),
                        )
                        .then(
                          (value) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CompatibilityDestinationsPage(),
                              ),
                            );
                          },
                          onError: (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  error.toString(),
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onErrorContainer,
                                  ),
                                ),
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.errorContainer,
                              ),
                            );
                            return null;
                          },
                        );
                  },
                  child: Text(GlobalState.of(context).localizations.confirm),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
