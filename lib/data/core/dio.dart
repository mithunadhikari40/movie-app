import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:personal/data/core/app_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// List whiteListDomains = ['localhost', '10.0.2.2'];

BaseOptions options = BaseOptions(
  baseUrl: '',
  connectTimeout: 45000, // 45 secs
  receiveTimeout:
      45000, // 45 secs Note: This is not the receiving time limitation. Only Error.
);
Dio dio = Dio(options);

void setBaseUrl() async {
  String url = BASE_URL;

  BaseOptions options = BaseOptions(
    baseUrl: url,
    connectTimeout: 45000, // 45 secs
    receiveTimeout:
        45000, // 45 secs Note: This is not the receiving time limitation. Only Error.
  );
  dio = Dio(options);
  dio = addInterceptors(dio);
  // dio = enableProxy(dio);

  dio = addPrettyInterceptors(dio);
}

Dio addPrettyInterceptors(Dio dio) {
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );
  return dio;
}

Dio addInterceptors(Dio dio) {
  dio.interceptors.add(InterceptorsWrapper(onRequest:
      (RequestOptions options, RequestInterceptorHandler handler) async {
    return handler.next(options);
  }, onResponse: (Response response, ResponseInterceptorHandler handler) async {
    // Do something with response data
    return handler.next(response);
  }, onError: (DioError e, ErrorInterceptorHandler handler) async {
    // Do something with response error
    // if (e.response == null) {
    //   UiUtils.showErrorAlert(
    //     message: 'Network Failure',
    //   );
    // } else {
    //   UiUtils.showErrorAlert(
    //     message: 'Not Found',
    //   );
    // }
    return handler.next(e);
  }));
  return dio;
}

void setUpDio() {
  dio = addInterceptors(dio);
  // dio = enableProxy(dio);
}

// Need to have two variables
// Port No for Charles 8888
// Port No for ProxyMan 9090
Dio enableProxy(Dio dio) {
  String proxyPort = "9090";

  String proxy =
      Platform.isAndroid ? '10.0.2.2:$proxyPort' : 'localhost:$proxyPort';

  var adapter = DefaultHttpClientAdapter();
  adapter.onHttpClientCreate = (client) {
    // Hook into the findProxy callback to set the client's proxy.
    client.findProxy = (url) {
      return 'PROXY $proxy';
    };

    // This is a workaround to allow Charles to receive
    // SSL payloads when your app is running on Android.
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => Platform.isAndroid;
    return client;
  };
  dio.httpClientAdapter = adapter;
  return dio;
}
