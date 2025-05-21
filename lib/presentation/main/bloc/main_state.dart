import 'package:equatable/equatable.dart';

enum MainStatus { loading, success, failure }

class MainState extends Equatable {
  const MainState({
    this.status = MainStatus.loading,
    this.userName = '',
    this.userAvatar = '',
    this.userStreak = 0,
    this.leaders = const [],
    this.xp = 0,
  });

  MainState copyWith({
    MainStatus? status,
    String? userName,
    String? userAvatar,
    int? userStreak,
    List<Map<String, dynamic>>? leaders,
    int? xp,
  }) {
    return MainState(
      status: status ?? this.status,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      userStreak: userStreak ?? this.userStreak,
      leaders: leaders ?? this.leaders,
      xp: xp ?? this.xp,
    );
  }

  final MainStatus status;
  final String userName;
  final String userAvatar;
  final int userStreak;
  final List<Map<String, dynamic>> leaders;
  final int xp;

  @override
  List<Object?> get props => [
        status,
        userName,
        userAvatar,
        userStreak,
        leaders,
        xp,
      ];
}
