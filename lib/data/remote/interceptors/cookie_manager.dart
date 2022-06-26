import 'dart:io';
import 'package:dio/dio.dart';
import 'package:moddhobitto_mobile/constant/strings.dart';
import 'package:moddhobitto_mobile/session/session_manager.dart';

class CookieManager extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var cookie = _getCookie();
    options.headers['X-request-source'] = 'ANDROID_DOCTOR_TABLET';
    if (cookie.isNotEmpty) options.headers[HttpHeaders.cookieHeader] = cookie;
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var cookies = response.headers[HttpHeaders.setCookieHeader];
    if (cookies != null) {
      _saveCookie(cookies[0]);
    }
    super.onResponse(response, handler);
  }

  String _getCookie() {
    return prefManager.prefs.getString(keyCookie) ?? '';
  }

  void _saveCookie(String newCookie) {
    var cookie = _getCookie();
    if (newCookie.contains('authId') && cookie != newCookie) {
      prefManager.prefs.setString(keyCookie, newCookie);
    }
  }
}
