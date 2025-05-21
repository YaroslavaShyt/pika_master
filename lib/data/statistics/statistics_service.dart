import 'package:pika_master/core/logger/logger.dart';
import 'package:pika_master/domain/leader/ileader.dart';
import 'package:pika_master/domain/leader/ileader_repository.dart';
import 'package:pika_master/domain/statistics/istatistics_service.dart';

class StatisticsService implements IStatisticsService {
  StatisticsService({
    required ILeaderRepository leaderRepository,
  }) : _leaderRepository = leaderRepository;

  final ILeaderRepository _leaderRepository;

  @override
  List<ILeader> get leaders => _leaders;
  List<ILeader> _leaders = [];

  @override
  Future<List<ILeader>> getLeaders() async {
    try {
      _leaders = await _leaderRepository.getLeadersData();
      return _leaders;
    } catch (error) {
      logger.e(error);
    }
    return [];
  }
}
