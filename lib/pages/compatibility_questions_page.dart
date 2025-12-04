import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/models/compatibility_questions_model.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/models/compatibility_options_model.dart';

@NowaGenerated()
class CompatibilityQuestionsPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityQuestionsPage({this.questionId = 1, super.key});

  final int? questionId;

  @override
  State<CompatibilityQuestionsPage> createState() {
    return _CompatibilityQuestionsPageState();
  }
}

@NowaGenerated()
class _CompatibilityQuestionsPageState
    extends State<CompatibilityQuestionsPage> {
  final Set<int> _selectedIndexes = Set.identity();

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Scaffold(
        body: SafeArea(
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
                width: double.infinity,
                child: DataBuilder<CompatibilityQuestionsModel?>(
                  builder: (context, data) => Material(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Theme.of(context).colorScheme.inversePrimary,
                    surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
                    child: ListTile(
                      title: Text(
                        data?.label['en'] ?? 'Question',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0,
                        ),
                      ),
                      subtitle: Text(
                        data?.section_id?.label['en'] ?? 'Section',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  loadingWidget: const Align(
                    alignment: Alignment(0.0, 0.0),
                    child: CircularProgressIndicator(),
                  ),
                  errorBuilder: (context, error) => Align(
                    alignment: const Alignment(0.0, 0.0),
                    child: Text(
                      error.toString(),
                      style: const TextStyle(color: Color(0xffff0000)),
                    ),
                  ),
                  future: SupabaseService().getByIdCompatibility_question(
                    widget.questionId!,
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
                      return Material(
                        elevation: 5.0,
                        color: _selectedIndexes.contains(index)
                            ? Theme.of(context).colorScheme.inversePrimary
                            : Theme.of(context).colorScheme.primaryContainer,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        surfaceTintColor: Theme.of(
                          context,
                        ).colorScheme.surfaceTint,
                        child: ListTile(
                          title: Text(
                            element.label['en'] ?? 'Option',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24.0,
                            ),
                          ),
                          subtitle: Text(
                            element.description['en'] ?? 'Description',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.justify,
                          ),
                          onTap: () {
                            setState(() {
                              if (_selectedIndexes.contains(index)) {
                                _selectedIndexes.remove(index);
                              } else {
                                if (element.question_id!.multi_select!) {
                                  _selectedIndexes.add(index);
                                } else {
                                  _selectedIndexes.clear();
                                  _selectedIndexes.add(index);
                                }
                              }
                            });
                          },
                          selected: _selectedIndexes.contains(index),
                        ),
                      );
                    },
                    padding: const EdgeInsets.symmetric(
                      vertical: 30.0,
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
                      style: const TextStyle(color: Color(0xffff0000)),
                    ),
                  ),
                  future: SupabaseService().getByIdCompatibility_options(
                    widget.questionId!,
                  ),
                ),
              ),
              FlexSizedBox(
                width: null,
                height: null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 8.0,
                  ),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      FlexSizedBox(
                        width: null,
                        height: null,
                        child: ElevatedButton(
                          onPressed: _selectedIndexes.isNotEmpty
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CompatibilityQuestionsPage(
                                            questionId: widget.questionId! + 1,
                                          ),
                                    ),
                                  );
                                }
                              : null,
                          child: const Text('Confirm'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
