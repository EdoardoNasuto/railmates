import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/global_state.dart';
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
  RangeValues days = const RangeValues(7.0, 28.0);

  DateTimeRange? dates;

  RangeValues mates = const RangeValues(2.0, 6.0);

  RangeValues budget = const RangeValues(400.0, 600.0);

  String? _toDateRange(DateTimeRange? range) {
    if (range == null) {
      return null;
    }
    final start = range.start.toIso8601String().split('T').first;
    final end = range.end.toIso8601String().split('T').first;
    return '[${start},${end}]';
  }

  String _toInt4Range(RangeValues range) {
    return '[${range.start.toInt()},${range.end.toInt()}]';
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
            spacing: 20.0,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlexSizedBox(
                width: null,
                height: null,
                child: Text(
                  GlobalState.of(context).localizations.importantInformation,
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              FlexSizedBox(
                width: null,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () async {
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      anchorPoint: const Offset(0.0, 0.0),
                      initialDateRange:
                          dates ??
                          DateTimeRange(
                            start: DateTime.now(),
                            end: DateTime.now().add(const Duration(days: 7)),
                          ),
                    );
                    if (picked != null) {
                      setState(() {
                        dates = picked;
                      });
                    }
                  },
                  onLongPress: null,
                  child: Text(
                    dates == null
                        ? GlobalState.of(context).localizations.yourAvailability
                        : '${dates?.start.toString().split(' ').first ?? ''} → ${dates?.end.toString().split(' ').first ?? ''}',
                  ),
                ),
              ),
              FlexSizedBox(
                child: Text(
                  GlobalState.of(context).localizations.idealTripDuration,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Text('${days.start.toInt()} - ${days.end.toInt()}'),
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
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
              FlexSizedBox(
                width: null,
                height: null,
                child: Text(
                  GlobalState.of(context).localizations.idealTripDuration,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Text('${mates.start.toInt()} - ${mates.end.toInt()}'),
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
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
              FlexSizedBox(
                width: null,
                height: null,
                child: Text(
                  GlobalState.of(context).localizations.idealTripDuration,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Text('${budget.start.toInt()} - ${budget.end.toInt()}'),
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
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
              FlexSizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    if (dates != null) {
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
                                      const CompatibilityCountriesPage(),
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
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            GlobalState.of(
                              context,
                            ).localizations.incompleteInformation,
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
                  child: Text(
                    GlobalState.of(context).localizations.continueButton,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
