import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:railmates/global_state.dart';
import 'package:railmates/models/group_members_model.dart';
import 'package:railmates/integrations/supabase_service.dart';
import 'package:railmates/models/group_destinations_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

@NowaGenerated()
class CompatibilityResultPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const CompatibilityResultPage({
    this.group_id = '58ccf004-e2cc-44e1-818f-67311ab9526d',
    super.key,
  });

  final String? group_id;

  @override
  State<CompatibilityResultPage> createState() {
    return _CompatibilityResultPageState();
  }
}

@NowaGenerated()
class _CompatibilityResultPageState extends State<CompatibilityResultPage> {
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
            spacing: 20.0,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlexSizedBox(
                width: double.infinity,
                height: null,
                child: ListTile(
                  title: Text(
                    GlobalState.of(context).localizations.appTitle,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    GlobalState.of(context).localizations.dates,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              FlexSizedBox(
                width: double.infinity,
                flex: 1,
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TabBar(
                        labelColor: Color(0xff000000),
                        tabs: const [
                          Tab(child: Text('Membres')),
                          Tab(child: Text('Destinations')),
                        ],
                      ),
                      FlexSizedBox(
                        width: double.infinity,
                        flex: 1,
                        child: TabBarView(
                          children: [
                            DataBuilder<List<GroupMembersModel>>(
                              builder: (context, data) => ListView.separated(
                                itemCount: data.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      height: 1.0,
                                      color: Color(0xffc4c4c4),
                                    ),
                                itemBuilder: (context, index) {
                                  final GroupMembersModel element = data[index];
                                  final user = element.user_id;
                                  return ListTile(
                                    leading:
                                        user?.avatar_url != null &&
                                            user!.avatar_url!.isNotEmpty
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              element.user_id!.avatar_url!,
                                            ),
                                            radius: 24.0,
                                          )
                                        : const CircleAvatar(
                                            radius: 24.0,
                                            child: Icon(Icons.person),
                                          ),
                                    title: Text(
                                      '${element.user_id?.first_name} ${element.user_id?.last_name}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (user?.gender != null &&
                                            user!.gender!.isNotEmpty)
                                          Text('Genre : ${user?.gender}'),
                                        if (user?.birth_date != null &&
                                            user!.birth_date!.isNotEmpty)
                                          Text(
                                            'Date de naissance : ${user?.birth_date}',
                                          ),
                                        if (user?.phone != null &&
                                            user!.phone!.isNotEmpty)
                                          Text('Téléphone : ${user?.phone}'),
                                      ],
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 16.0,
                                    ),
                                    tileColor: const Color(0x66ffe1b0),
                                  );
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
                                  style: const TextStyle(
                                    color: Color(0xffff0000),
                                  ),
                                ),
                              ),
                              future: SupabaseService().getAllGroup_members(
                                widget.group_id!,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                              ),
                              child: DataBuilder<List<GroupDestinationsModel>>(
                                builder: (context, data) => GridView.custom(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 10.0,
                                        crossAxisSpacing: 10.0,
                                        childAspectRatio: 0.8,
                                      ),
                                  childrenDelegate: SliverChildBuilderDelegate((
                                    context,
                                    index,
                                  ) {
                                    final GroupDestinationsModel element =
                                        data[index];
                                    return Material(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainer,
                                      elevation: 5.0,
                                      shadowColor: Theme.of(
                                        context,
                                      ).colorScheme.shadow,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          24.0,
                                        ),
                                        side: BorderSide(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.inversePrimary,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16.0,
                                          horizontal: 16.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          spacing: 10.0,
                                          children: [
                                            FlexSizedBox(
                                              width: double.infinity,
                                              flex: 1,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: SvgPicture(
                                                  SvgNetworkLoader(
                                                    element
                                                        .countries_id!
                                                        .flag_url!,
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              element.countries_id!.name!,
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              'Vote : ${element.counts?.toString()}',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }, childCount: data.length),
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
                                      color: Color(0xffff0000),
                                    ),
                                  ),
                                ),
                                future: SupabaseService()
                                    .getAllGroup_destinations(widget.group_id!),
                              ),
                            ),
                          ],
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
    );
  }
}
