import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/pages/compatibility_essentials_page.dart';
import 'package:railmates/models/compatibility_model.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/pages/compatibility_destinations_page.dart';
import 'package:railmates/models/compatibility_destinations_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:railmates/models/compatibility_answers_model.dart';
import 'package:railmates/pages/compatibility_questions_page.dart';
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
          color: const Color(0xFF000000),
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
            spacing: 15.0,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FlexSizedBox(
                width: double.infinity,
                child: Material(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  color: Theme.of(context).colorScheme.surfaceContainerLowest,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const CompatibilityEssentialsPage(),
                        ),
                      );
                    },
                    child: DataBuilder<CompatibilityModel?>(
                      builder: (context, data) => Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 10.0,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.emoji_people,
                                size: 40.0,
                                color: Theme.of(context).colorScheme.primary,
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
                                        ).colorScheme.primary,
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
                                              ).colorScheme.primary,
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
                                        ).colorScheme.secondary,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        data?.days ?? '-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.85),
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
                                        ).colorScheme.secondary,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        data?.mates ?? '-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.85),
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
                                        ).colorScheme.secondary,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        data?.budget ?? '-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.85),
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
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                child: Material(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const CompatibilityDestinationsPage(),
                        ),
                      );
                    },
                    child: DataBuilder<List<CompatibilityDestinationsModel>>(
                      builder: (context, data) => GridView.custom(
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
                            elevation: 5.0,
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
                      future: SupabaseService()
                          .getAllCompatibility_destinations(),
                    ),
                  ),
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                flex: 1,
                child: Material(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  elevation: 5.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FlexSizedBox(
                        width: double.infinity,
                        height: 48.0,
                        child: Material(
                          elevation: 0.0,
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
                          ).colorScheme.surfaceContainerLow,
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
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                    Tab(
                                      child: Icon(
                                        Icons.train_outlined,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                    Tab(
                                      child: Icon(
                                        Icons.hotel_outlined,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                    Tab(
                                      child: Icon(
                                        Icons.local_activity_outlined,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: DataBuilder<List<CompatibilityAnswersModel>>(
                            builder: (context, data) => ListView.separated(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final CompatibilityAnswersModel element =
                                    data[index];
                                return Material(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(18.0),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CompatibilityQuestionsPage(
                                                questionPos:
                                                    element.question_id?.pos,
                                              ),
                                        ),
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
                                                  ).colorScheme.primary,
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
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface
                                                      .withOpacity(0.85),
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
                                vertical: 10.0,
                                horizontal: 10.0,
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
                                style: const TextStyle(
                                  color: Color(0xFFFF0000),
                                ),
                              ),
                            ),
                            future: SupabaseService()
                                .getBySectionCompatibility_answers(section),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(index: 0),
    );
  }
}
