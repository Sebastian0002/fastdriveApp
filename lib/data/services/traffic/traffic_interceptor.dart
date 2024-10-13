part of 'traffic_service.dart';

class _TrafficInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.queryParameters.addAll({
      "alternatives": true,
      "geometries" : "polyline6",
      "overview" : "simplified",
      "steps" : false,
      "access_token" : "pk.eyJ1IjoiamhvYW5uMDIyIiwiYSI6ImNtMXk1b3p0djA1ZTIya29oZHZ4cnRsc2oifQ.Rah2zqhCwTGTEDWlwtE7jw"
    });

    super.onRequest(options, handler);
  }

}

