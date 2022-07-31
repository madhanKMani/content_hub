class AuthInterceptor extends QueuedInterceptorsWrapper {
  @override
  onRequest(request, handler) {
    return handler.next(request);
  }

  @override
  onResponse(response, handler) {
    return handler.next(response);
  }

  @override
  onError(DioError error, handler) async {
    if (error.response?.statusCode == 401) {
      // unauthorize error
      await refreshToken();
      // now updated token is in local storage
      var token = "token from local storage";
      final RequestOptions reqOptions = error.requestOptions;
      reqOptions.headers['Authorization'] = 'Bearer $token';

      // create option for new Request
      var newReqOption = Options(
        method: reqOptions.method,
        contentType: reqOptions.contentType,
        responseType: reqOptions.responseType,
        headers: reqOptions.headers,
      );

      // send new request by copying previous request data.
      var response = await dio.request(
        reqOptions.path,
        options: newReqOption,
        data: reqOptions.data,
        cancelToken: reqOptions.cancelToken,
        queryParameters: reqOptions.queryParameters,
        onReceiveProgress: reqOptions.onReceiveProgress,
        onSendProgress: reqOptions.onSendProgress,
      );

      if (response.data != null) {
        return handler.resolve(response);
      } else {
        return handler.next(error);
      }
    } else {
      // other status error can be handled here
      return handler.next(error);
    }
  }
}

Future<void> refreshToken() async {
  // refresh token api call goes here
  // after getting successfull response, save it in local storage
}

class AppDioClient {
  static Dio get instance {
    var dio = Dio();
    dio.interceptors..add(AuthInterceptor());
    return dio;
  }
}
