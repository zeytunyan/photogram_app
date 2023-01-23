import 'package:photogram_app/data/services/auth_service.dart';
import 'package:photogram_app/domain/models/refresh_token_request.dart';
import 'package:photogram_app/internal/config/token_storage.dart';
import 'package:photogram_app/ui/navigation/app_navigator.dart';
import 'package:dio/dio.dart';

import '../../data/clients/api_client.dart';
import '../../data/clients/auth_client.dart';
import '../config/app_config.dart';

class ApiModule {
  static AuthClient? _authClient;
  static ApiClient? _apiClient;

  static AuthClient auth() =>
      _authClient ?? AuthClient(Dio(), baseUrl: baseUrl);

  static ApiClient api() =>
      _apiClient ?? ApiClient(_addInterceptors(Dio()), baseUrl: baseUrl);

  static Dio _addInterceptors(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenStorage.getAccessToken();
        options.headers.addAll({"Authorization": "Bearer $token"});
        return handler.next(options);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode != 401) {
          return handler.next(e);
        }

        // ignore: deprecated_member_use
        dio.lock();
        RequestOptions options = e.response!.requestOptions;

        var rt = await TokenStorage.getRefreshToken();

        try {
          if (rt != null) {
            var token = await auth()
                .refreshToken(RefreshTokenRequest(refreshToken: rt));
            await TokenStorage.setStoredToken(token);
            options.headers["Authorization"] = "Bearer ${token!.accessToken}";
          }
        } catch (e) {
          var service = AuthService();

          //if (await service.checkAuth()) {
          await service.cleanToken();
          AppNavigator.toLoader();
          //}

          return handler
              .resolve(Response(statusCode: 400, requestOptions: options));
        } finally {
          // ignore: deprecated_member_use
          dio.unlock();
        }

        return handler.resolve(await dio.fetch(options));
      },
    ));

    return dio;
  }
}
