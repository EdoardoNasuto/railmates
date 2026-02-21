import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/models/compatibility_questions_model.dart';
import 'package:railmates/global_state.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/models/compatibility_options_model.dart';
import 'package:railmates/models/compatibility_model.dart';
import 'package:railmates/pages/compatibility_group_page.dart';

@NowaGenerated()
class CompatibilityQuestionsPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityQuestionsPage({
    this.questionPos = 1,
    this.questionsCount = 20,
    super.key,
  });

  final int? questionPos;

  final int? questionsCount;

  @override
  State<CompatibilityQuestionsPage> createState() {
    return _CompatibilityQuestionsPageState();
  }
}

@NowaGenerated()
class _CompatibilityQuestionsPageState
    extends State<CompatibilityQuestionsPage> {
  final Set<int> _selectedOptionIds = Set.identity();

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
                child: DataBuilder<CompatibilityQuestionsModel?>(
                  builder: (context, data) => Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    children: [
                      FlexSizedBox(
                        width: null,
                        height: null,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 0.0,
                            bottom: 15.0,
                            left: 0.0,
                            right: 0.0,
                          ),
                          child: Material(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: LinearProgressIndicator(
                              value:
                                  widget.questionPos! / widget.questionsCount!,
                              minHeight: 10.0,
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      FlexSizedBox(
                        width: null,
                        height: null,
                        child: Text(
                          data?.section_id?.label[GlobalState.of(
                                context,
                                listen: false,
                              ).locale!.languageCode] ??
                              'Section',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w800,
                            fontSize: 30.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FlexSizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                            bottom: 30.0,
                            left: 0.0,
                            right: 0.0,
                          ),
                          child: Material(
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            surfaceTintColor: Theme.of(
                              context,
                            ).colorScheme.surfaceTint,
                            child: ListTile(
                              title: Text(
                                data?.label[GlobalState.of(
                                      context,
                                      listen: false,
                                    ).locale!.languageCode] ??
                                    GlobalState.of(
                                      context,
                                    ).localizations.question,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.0,
                                ),
                              ),
                              subtitle: Visibility(
                                visible: data!.multi_select!,
                                child: Text(
                                  GlobalState.of(
                                    context,
                                  ).localizations.multipleAnswersPossible,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  loadingWidget: const Align(
                    alignment: Alignment(0.0, 0.0),
                    child: CircularProgressIndicator(),
                  ),
                  errorBuilder: (context, error) => Align(
                    alignment: const Alignment(0.0, 0.0),
                    child: Text(
                      error.toString(),
                      style: const TextStyle(color: Color(0xFFFF0000)),
                    ),
                  ),
                  future: SupabaseService().getByPosCompatibility_question(
                    widget.questionPos!,
                  ),
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                flex: 1,
                child: DataBuilder<List<CompatibilityOptionsModel>>(
                  builder: (context, data) => ListView.separated(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final CompatibilityOptionsModel element = data[index];
                      final int optionId = element.id!;
                      return Material(
                        elevation: 5.0,
                        color: _selectedOptionIds.contains(optionId)
                            ? Theme.of(context).colorScheme.inversePrimary
                            : Theme.of(
                                context,
                              ).colorScheme.surfaceContainerLowest,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        surfaceTintColor: Theme.of(
                          context,
                        ).colorScheme.surfaceTint,
                        child: ListTile(
                          title: Text(
                            element.label[GlobalState.of(
                                  context,
                                  listen: false,
                                ).locale!.languageCode] ??
                                GlobalState.of(context).localizations.option,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24.0,
                            ),
                          ),
                          subtitle: Text(
                            element.description[GlobalState.of(
                                  context,
                                  listen: false,
                                ).locale!.languageCode] ??
                                GlobalState.of(
                                  context,
                                ).localizations.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.justify,
                          ),
                          onTap: () {
                            setState(() {
                              if (_selectedOptionIds.contains(optionId)) {
                                _selectedOptionIds.remove(optionId);
                              } else {
                                if (element.question_id!.multi_select!) {
                                  _selectedOptionIds.add(optionId);
                                } else {
                                  _selectedOptionIds.clear();
                                  _selectedOptionIds.add(optionId);
                                }
                              }
                            });
                          },
                        ),
                      );
                    },
                    padding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 8.0,
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20.0, width: 20.0),
                  ),
                  loadingWidget: const Align(
                    alignment: Alignment(0.0, 0.0),
                    child: CircularProgressIndicator(),
                  ),
                  errorBuilder: (context, error) => Align(
                    alignment: const Alignment(0.0, 0.0),
                    child: Text(
                      error.toString(),
                      style: const TextStyle(color: Color(0xFFFF0000)),
                    ),
                  ),
                  future: SupabaseService().getByPosCompatibility_options(
                    widget.questionPos!,
                  ),
                ),
              ),
              FlexSizedBox(
                width: null,
                height: null,
                child: ElevatedButton(
                  onPressed: _selectedOptionIds.isNotEmpty
                      ? () async {
                          final CompatibilityQuestionsModel? question =
                              await SupabaseService()
                                  .getByPosCompatibility_question(
                                    widget.questionPos!,
                                  );
                          await SupabaseService().deleteCompatibility_answers(
                            question!.id!,
                          );
                          await SupabaseService().createCompatibility_answers(
                            _selectedOptionIds.toList(),
                          );
                          if (widget.questionPos == widget.questionsCount) {
                            SupabaseService().updateCompatibility(
                              const CompatibilityModel(ready: true),
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CompatibilityGroupPage(),
                              ),
                            );
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    CompatibilityQuestionsPage(
                                      questionPos: widget.questionPos! + 1,
                                    ),
                              ),
                            );
                          }
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                      states,
                    ) {
                      if (states.contains(WidgetState.disabled)) {
                        return null;
                      }
                      if (states.contains(WidgetState.hovered)) {
                        return null;
                      }
                      return Theme.of(context).colorScheme.primaryContainer;
                    }),
                    foregroundColor: const WidgetStatePropertyAll<Color?>(null),
                    shadowColor: const WidgetStatePropertyAll<Color?>(null),
                    elevation: const WidgetStatePropertyAll<double?>(null),
                    side: const WidgetStatePropertyAll<BorderSide?>(null),
                    shape:
                        const WidgetStatePropertyAll<RoundedRectangleBorder?>(
                          null,
                        ),
                  ),
                  child: Text(GlobalState.of(context).localizations.confirm),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }

  @override
  Future<void> initState() async {
    final takenOptions = await SupabaseService()
        .getByQuestionPosCompatibility_answers(widget.questionPos!);
    takenOptions.forEach((element) {
      _selectedOptionIds.add(element.option_id!.id!);
    });
    super.initState();
    setState(() {});
  }
}
