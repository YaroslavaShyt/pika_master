import 'package:pika_master/data/user/app_user.dart';
import 'package:pika_master/domain/networking/inetworking_client.dart';
import 'package:pika_master/domain/user/iapp_user.dart';
import 'package:pika_master/domain/user/iuser_repository.dart';

class UserRepository implements IUserRepository {
  UserRepository({
    required INetworkClient networkClient,
  }) : _networkClient = networkClient;

  final INetworkClient _networkClient;
  final String _collection = 'pikachuUsers';

  @override
  Future<void> createUser({required IAppUser user}) async {
    final result = await _networkClient.get(
      endpoint: _collection,
      queryParameters: {
        'email': user.email,
      },
    );

    final usersWithEmail = result as List?;

    if (usersWithEmail == null || usersWithEmail.isEmpty) {
      await _networkClient.put(
        endpoint: _collection,
        additionalParam: user.id,
        data: user.toJson(),
      );
    }
  }

  @override
  Future<IAppUser?> getUser({
    required String email,
  }) async {
    final result = await _networkClient.get(
      endpoint: _collection,
      queryParameters: {"email": email},
    );

    if (result == null) return null;

    return AppUser.fromJson(result.first);
  }

  @override
  Future<void> deleteUser({required String id}) async {
    await _networkClient.delete(
      endpoint: _collection,
      additionalParam: id,
    );
  }

  @override
  Future<void> updateUser({required IAppUser newUser}) async {
    await _networkClient.put(
      endpoint: _collection,
      additionalParam: newUser.id,
      data: newUser.toJson(),
    );
  }
}
