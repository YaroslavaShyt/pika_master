import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pika_master/presentation/main/bloc/main_cubit.dart';
import 'package:pika_master/presentation/main/bloc/main_state.dart';
import 'package:pika_master/presentation/main/widgets/leader_board/leader_board_widget.dart';
import 'package:pika_master/presentation/main/widgets/user_info/start_game_widget.dart';
import 'package:pika_master/presentation/main/widgets/user_info/user_info_widget.dart';
import 'package:pika_master/presentation/widgets/buttons/main_outlined_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    required this.cubit,
    super.key,
  });

  final MainCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: cubit.onLogoutTapped,
        child: const FaIcon(
          FontAwesomeIcons.rightFromBracket,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            if (state.status == MainStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.status == MainStatus.failure) {
              return Center(
                child: Text("Oops"),
              );
            }
            return Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 16,
                top: 16,
                end: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  UserInfoWidget(
                    streak: state.userStreak,
                    userName: state.userName,
                    avatarPath: state.userAvatar,
                  ),
                  StartGameWidget(
                    xp: state.xp,
                    onTap: cubit.onStartRoundButtonTapped,
                  ),
                  Expanded(
                    child: LeaderBoardWidget(
                      leaders: state.leaders,
                    ),
                  ),
                  MainOutlinedButton(
                    onPressed: () => _changeLocale(context),
                    child: Text(
                      context.locale.languageCode,
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _changeLocale(BuildContext context) {
    final String currentLang = context.locale.languageCode;
    final Locale newLocale = currentLang == 'uk'
        ? const Locale('en', 'GB')
        : const Locale('uk', 'UA');

    context.setLocale(newLocale);
    cubit.onLocalizationTap(context, langCode: newLocale.languageCode);
  }
}
