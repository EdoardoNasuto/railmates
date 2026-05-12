import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/models/compatibility_model.dart';
import 'package:go_router/go_router.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/models/compatibility_destinations_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:railmates/models/compatibility_answers_model.dart';
import 'package:railmates/global_state.dart';
import 'package:railmates/components/nav_bar.dart';

@NowaGenerated()
class HomePage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

@NowaGenerated()
class _HomePageState extends State<HomePage> {
  int section = 2;

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
          maintainBottomViewPadding: false,
          minimum: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            spacing: 20.0,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FlexSizedBox(
                width: double.infinity,
                child: DataBuilder<CompatibilityModel?>(
                  builder: (context, data) => Material(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    child: InkWell(
                      onTap: () {
                        GoRouter.of(
                          context,
                        ).pushNamed('compatibility_essentials');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 10.0,
                          children: [
                            Material(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainer,
                              child: Icon(
                                Icons.emoji_people,
                                size: 40.0,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 18.0,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        data?.dates ?? '-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurface,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.today,
                                        size: 18.0,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        data?.days ?? '-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurface,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.group,
                                        size: 18.0,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        data?.mates ?? '-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurface,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.euro,
                                        size: 18.0,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        data?.budget ?? '-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurface,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                      style: const TextStyle(color: Color(0xFFFF0000)),
                    ),
                  ),
                  future: SupabaseService().getUserCompatibility(),
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                child: DataBuilder<List<CompatibilityDestinationsModel>>(
                  builder: (context, data) => Material(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: InkWell(
                      onTap: () {
                        GoRouter.of(
                          context,
                        ).pushNamed('compatibility_destinations');
                      },
                      child: GridView.custom(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                            ),
                        childrenDelegate: SliverChildBuilderDelegate((
                          context,
                          index,
                        ) {
                          final CompatibilityDestinationsModel element =
                              data[index];
                          return Material(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            elevation: 3.0,
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainer,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: SvgPicture(
                                SvgNetworkLoader(element.country_id!.flag_url!),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        }, childCount: data.length),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 15.0,
                        ),
                        shrinkWrap: true,
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
                      style: const TextStyle(color: Color(0xFFFF0000)),
                    ),
                  ),
                  future: SupabaseService().getAllCompatibility_destinations(),
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                flex: 1,
                child: DataBuilder<List<CompatibilityAnswersModel>>(
                  builder: (context, data) => Material(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    elevation: 3.0,
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FlexSizedBox(
                          width: double.infinity,
                          height: 48.0,
                          child: Material(
                            elevation: 1.0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0),
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                              ),
                            ),
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainer,
                            child: DefaultTabController(
                              length: 2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TabBar(
                                    labelColor: const Color(0xFF000000),
                                    tabs: [
                                      Tab(
                                        child: Icon(
                                          Icons.calendar_month,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                      ),
                                      Tab(
                                        child: Icon(
                                          Icons.train_outlined,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                      ),
                                      Tab(
                                        child: Icon(
                                          Icons.hotel_outlined,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                      ),
                                      Tab(
                                        child: Icon(
                                          Icons.local_activity_outlined,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                      ),
                                    ],
                                    onTap: (value) {
                                      section = value + 2;
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        FlexSizedBox(
                          width: double.infinity,
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 5.0,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: ListView.separated(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final CompatibilityAnswersModel element =
                                      data[index];
                                  return Material(
                                    elevation: 1.0,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(18.0),
                                      onTap: () {
                                        GoRouter.of(context).pushNamed(
                                          'compatibility_questions',
                                          queryParameters: {
                                            'questionPos':
                                                element.question_id?.pos
                                                    ?.toString() ??
                                                '1',
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 15.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              element
                                                      .question_id
                                                      ?.label[GlobalState.of(
                                                    context,
                                                    listen: false,
                                                  ).locale!.languageCode] ??
                                                  GlobalState.of(
                                                    context,
                                                  ).localizations.question,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.onSurface,
                                                  ),
                                            ),
                                            Text(
                                              element
                                                      .option_id
                                                      ?.label[GlobalState.of(
                                                    context,
                                                    listen: false,
                                                  ).locale!.languageCode] ??
                                                  GlobalState.of(
                                                    context,
                                                  ).localizations.option,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.onSurface,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10.0, width: 20.0),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                  horizontal: 5.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                      style: const TextStyle(color: Color(0xFFFF0000)),
                    ),
                  ),
                  future: SupabaseService().getBySectionCompatibility_answers(
                    section,
                  ),
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                child: Row(
                  spacing: 10.0,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlexSizedBox(
                      width: 60.0,
                      height: 40.0,
                      child: DataBuilder<CompatibilityModel?>(
                        builder: (context, data) => Switch(
                          value: data!.ready!,
                          onChanged: (value) {
                            SupabaseService()
                                .updateCompatibility(
                                  CompatibilityModel(ready: value),
                                )
                                .then((value) {
                                  setState(() {});
                                });
                          },
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
                        future: SupabaseService().getUserCompatibility(),
                      ),
                    ),
                    const FlexSizedBox(
                      width: null,
                      height: null,
                      child: Text('Je suis en recherche de compagnons'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(index: 0),
      appBar: AppBar(
        title: const Text('Summary'),
        elevation: 1.0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
