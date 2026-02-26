import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/application/extensions/async_value_extension.dart';
import '../../../../../core/application/extensions/hardcoded_string_extension.dart';
import '../../../../../core/application/extensions/theme_build_context_extension.dart';
import '../../../../../core/presentation/widgets/buttons/primary_flat_button.dart';
import '../../../../../core/presentation/widgets/cards/card_widget.dart';
import '../../controllers/auth_controller.dart';
import 'widgets/stats_widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  Future<void> _signOut() =>
      ref.read(authControllerProvider.notifier).signOut();

  @override
  bool get wantKeepAlive => true;

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  String _getCreationDateString(DateTime? createdAt) {
    if (createdAt == null) return '';

    String monthName = _getMonthName(createdAt.month);
    int year = createdAt.year;

    return 'Since $monthName $year';
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ref.listen<AsyncValue<void>>(
      authControllerProvider,
      (_, state) => state.showSnackBarOnError(context),
    );

    final authState = ref.watch(authControllerProvider);
    final user = authState.value?.name ?? '';
    final userEMail = authState.value?.email ?? '';
    final userCreatedAt = _getCreationDateString(authState.value?.createdAt);
    final isLoading = (authState.isLoading == true);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 16),
                  CardWidget(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Center(
                              child: Column(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 45,
                                        backgroundColor: context.colors.primary,
                                      ),
                                      Positioned(
                                        right: 5,
                                        bottom: 0,
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: context.colors.white,
                                          child: Center(
                                            child: CircleAvatar(
                                              radius: 8,
                                              backgroundColor: Color(
                                                0xFF48bb78,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    user,
                                    style: context.textStyles.text20Bold,
                                  ),
                                  Text(
                                    'Free Member',
                                    style: context.textStyles.text14w500
                                        .copyWith(
                                          color: context.colors.titaniumEcho,
                                        ),
                                  ),
                                  const SizedBox(height: 16),
                                  Card(
                                    elevation: 0,
                                    color: context.colors.pureMist,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                context.colors.vividOrchid,
                                            child: Icon(
                                              Icons.email_outlined,
                                              size: 16,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(userEMail),
                                              Text(
                                                userCreatedAt,
                                                style: context
                                                    .textStyles
                                                    .text12w500
                                                    .copyWith(
                                                      color: context
                                                          .colors
                                                          .titaniumEcho
                                                          .withValues(
                                                            alpha: 0.5,
                                                          ),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate(delay: 0.3.ms)
                      .fadeIn(
                        begin: 0,
                        duration: 300.ms,
                        curve: Curves.easeInOut,
                      ),
                  const SizedBox(height: 16),
                  CardWidget(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              'Activity Stats'.hardcoded,
                              style: context.textStyles.text14Bold,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                StatsWidget(
                                  title: '27'.hardcoded,
                                  subTitle: 'Chats'.hardcoded,
                                ),
                                StatsWidget(
                                  title: '1.8k'.hardcoded,
                                  subTitle: 'Messages'.hardcoded,
                                  statsColor: context.colors.vividOrchid,
                                ),
                                StatsWidget(
                                  title: '9'.hardcoded,
                                  subTitle: 'Days Active'.hardcoded,
                                  statsColor: context.colors.electricCyan,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                      .animate(delay: 0.6.ms)
                      .fadeIn(
                        begin: 0,
                        duration: 300.ms,
                        curve: Curves.easeInOut,
                      ),
                  const SizedBox(height: 20),
                  Row(
                        children: <Widget>[
                          Expanded(
                            child: PrimaryFlatButton(
                              decoration:
                                  context.decorations.tertiaryButtonDecoration,
                              text: 'Logout',
                              prefix: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Icon(Icons.logout_outlined),
                              ),
                              onTap: isLoading ? null : _signOut,
                            ),
                          ),
                        ],
                      )
                      .animate(delay: 0.9.ms)
                      .fadeIn(
                        begin: 0,
                        duration: 300.ms,
                        curve: Curves.easeInOut,
                      ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
