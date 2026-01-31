import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/models/compatibility_model.dart';
import 'package:railmates/pages/compatibility_countries_page.dart';

@NowaGenerated()
class CompatibilityDaysPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityDaysPage({super.key});

  @override
  State<CompatibilityDaysPage> createState() {
    return _CompatibilityDaysPageState();
  }
}

@NowaGenerated()
class _CompatibilityDaysPageState extends State<CompatibilityDaysPage> {
  int? minDays = 7;

  int? maxDays = 28;

  DateTime? startDate;

  DateTime? endDate;

  int? minMates = 2;

  int? maxMates = 6;

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
            spacing: 20.0,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FlexSizedBox(
                width: null,
                height: null,
                child: Text(
                  'Important information',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800),
                ),
              ),
              FlexSizedBox(
                width: null,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () {
                    showDateRangePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      anchorPoint: const Offset(0.0, 0.0),
                      initialDateRange: DateTimeRange(
                        start: startDate ?? DateTime.now(),
                        end: endDate ?? DateTime.now(),
                      ),
                    ).then((value) {
                      startDate = value?.start;
                      endDate = value?.end;
                    });
                  },
                  onLongPress: null,
                  child: const Text('Your availability'),
                ),
              ),
              const FlexSizedBox(
                child: Text(
                  'Ideal trip duration ?',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    FlexSizedBox(
                      width: null,
                      height: null,
                      child: Text('At least ' + minDays!.toString() + ' days'),
                    ),
                    FlexSizedBox(
                      width: null,
                      height: null,
                      child: NSlider(
                        value: minDays!.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            minDays = value.toInt();
                          });
                        },
                        max: 28.0,
                        divisions: 3,
                        min: 7.0,
                        thumbColor: Theme.of(context).colorScheme.surface,
                        activeColor: Theme.of(context).colorScheme.primary,
                        overlayColor: Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                    FlexSizedBox(
                      width: null,
                      height: null,
                      child: Text('At most ' + maxDays!.toString() + ' days'),
                    ),
                    FlexSizedBox(
                      width: null,
                      height: null,
                      child: NSlider(
                        value: maxDays!.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            maxDays = value.toInt();
                          });
                        },
                        max: 28.0,
                        divisions: 3,
                        min: 7.0,
                        activeColor: Theme.of(context).colorScheme.primary,
                        overlayColor: Theme.of(context).colorScheme.onTertiary,
                        thumbColor: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
              const FlexSizedBox(
                width: null,
                height: null,
                child: Text(
                  'What is your ideal group size ?',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
              ),
              FlexSizedBox(
                width: null,
                height: null,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    FlexSizedBox(
                      width: null,
                      height: null,
                      child: Text('At least ' + minMates!.toString() + ' days'),
                    ),
                    FlexSizedBox(
                      width: null,
                      height: null,
                      child: NSlider(
                        value: minMates!.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            minMates = value.toInt();
                          });
                        },
                        max: 6.0,
                        divisions: 4,
                        min: 2.0,
                        thumbColor: Theme.of(context).colorScheme.surface,
                        activeColor: Theme.of(context).colorScheme.primary,
                        overlayColor: Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                    FlexSizedBox(
                      width: null,
                      height: null,
                      child: Text('At most ' + maxMates!.toString() + ' days'),
                    ),
                    FlexSizedBox(
                      width: null,
                      height: null,
                      child: NSlider(
                        value: maxMates!.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            maxMates = value.toInt();
                          });
                        },
                        max: 6.0,
                        divisions: 4,
                        min: 2.0,
                        activeColor: Theme.of(context).colorScheme.primary,
                        overlayColor: Theme.of(context).colorScheme.onTertiary,
                        thumbColor: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
              FlexSizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    if (startDate != null && endDate != null) {
                      SupabaseService()
                          .createCompatibility(
                            CompatibilityModel(
                              start_date: startDate?.toString(),
                              end_date: endDate?.toString(),
                              min_days: minDays,
                              max_days: maxDays,
                              min_mates: minMates,
                              max_mates: maxMates,
                            ),
                          )
                          .then(
                            (value) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CompatibilityCountriesPage(),
                                ),
                              );
                            },
                            onError: (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Invalid data, check the entries',
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
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Incomplete information',
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
                    }
                  },
                  child: const Text('Button'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
