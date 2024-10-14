part of 'traffic_service.dart';

class _PlacesInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.queryParameters.addAll({
      "access_token" : mapboxToken,
      "limit": 10
    });

    super.onRequest(options, handler);
  }
}