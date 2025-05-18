import 'package:pika_master/domain/networking/inetworking_client.dart';
import 'package:pika_master/domain/user/iapp_user.dart';
import 'package:pika_master/domain/user/iuser_repository.dart';

class UserRepository implements IUserRepository {
  UserRepository({
    required INetworkClient networkClient,
  }) : _networkClient = networkClient;

  final INetworkClient _networkClient;

  @override
  Future<IAppUser?> getUser({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser({required String id}) {
    throw UnimplementedError();
  }
}
