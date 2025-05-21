import 'package:pika_master/domain/leader/ileader.dart';

abstract interface class IStatisticsService {
  Future<List<ILeader>> getLeaders();

  List<ILeader> get leaders;
}
