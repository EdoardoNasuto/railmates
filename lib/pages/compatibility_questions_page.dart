import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/models/compatibility_questions_model.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/models/compatibility_options_model.dart';

@NowaGenerated()
class CompatibilityQuestionsPage extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityQuestionsPage({this.questionId = 1, super.key});

  final int? questionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: false,
        minimum: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          spacing: 10.0,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlexSizedBox(
              width: double.infinity,
              child: DataBuilder<CompatibilityQuestionsModel?>(
                builder: (context, data) => ListTile(
                  title: Text(
                    data?.label['en'] ?? 'Question',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  subtitle: Text(
                    data?.section_id?.label['en'] ?? 'Section',
                    textAlign: TextAlign.center,
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
                  questionId!,
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
                    return SizedBox(
                      height: 120.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondaryContainer,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FlexSizedBox(
                              width: null,
                              height: null,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 4.0,
                                  bottom: 2.0,
                                  left: 10.0,
                                  right: 10.0,
                                ),
                                child: Text(
                                  element.label['en'] ?? 'title',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                            FlexSizedBox(
                              width: null,
                              height: null,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 2.0,
                                  bottom: 10.0,
                                  left: 10.0,
                                  right: 10.0,
                                ),
                                child: Text(
                                  element.description['en'] ?? 'description',
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16.0, width: 20.0),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 0.0,
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
                future: SupabaseService().getByIdCompatibility_options(
                  questionId!,
                ),
              ),
            ),
            FlexSizedBox(
              width: null,
              height: null,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CompatibilityQuestionsPage(
                        questionId: questionId! + 1,
                      ),
                    ),
                  );
                },
                child: const Text('Button'),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
