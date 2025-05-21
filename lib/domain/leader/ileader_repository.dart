import 'package:pika_master/domain/leader/ileader.dart';

abstract interface class ILeaderRepository {
  Future<List<ILeader>> getLeadersData();
}
