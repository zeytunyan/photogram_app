import 'package:photogram_app/data/repository/api_data_repository.dart';
import 'package:photogram_app/domain/repository/api_repository.dart';
import 'package:photogram_app/internal/dependencies/api_module.dart';

class RepositoryModule {
  static ApiRepository? _apiRepository;

  static ApiRepository apiRepository() =>
      _apiRepository ?? ApiDataRepository(ApiModule.auth(), ApiModule.api());
}
