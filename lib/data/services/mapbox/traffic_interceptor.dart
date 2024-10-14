part of 'traffic_service.dart';

class _TrafficInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.queryParameters.addAll({
      "alternatives": true,
      "geometries" : "polyline6",
      "overview" : "simplified",
      "steps" : false,
      "access_token" : mapboxToken
    });
    super.onRequest(options, handler);
  }

}

