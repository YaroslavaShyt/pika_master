import 'package:equatable/equatable.dart';

enum MainStatus { loading, loaded }

class MainState extends Equatable {
  const MainState({
    this.status = MainStatus.loaded,
  });

  final MainStatus status;

  @override
  List<Object?> get props => [status];
}
