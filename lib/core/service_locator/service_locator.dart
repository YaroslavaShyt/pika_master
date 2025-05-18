import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

class ServiceLocator {
  void init() {
    _initRepos();
    _initStorage();
    _initServices();
    _initHandlers();
  }

  void _initRepos() {}

  void _initServices() {}

  void _initHandlers() {}

  void _initStorage() {}
}
