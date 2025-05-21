import 'package:pika_master/data/leader/leader.dart';
import 'package:pika_master/domain/leader/ileader.dart';
import 'package:pika_master/domain/leader/ileader_repository.dart';
import 'package:pika_master/domain/networking/inetworking_client.dart';

class LeaderRepository implements ILeaderRepository {
  final INetworkClient _networkClient;

  LeaderRepository({
    required INetworkClient networkClient,
  }) : _networkClient = networkClient;

  @override
  Future<List<ILeader>> getLeadersData() async {
    try {
      final data = await _networkClient.get(
        endpoint: 'pikachuUsers',
        queryParameters: {
          'xp': {'isGreaterThan': 0},
        },
      );

      return data
          .map<ILeader>(
            (e) => Leader.fromJson(e),
          )
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch leaders data: $e");
    }
  }
}
