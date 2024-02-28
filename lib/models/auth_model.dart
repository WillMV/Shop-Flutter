import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping/data/store.dart';
import 'package:shopping/exceptions/auth_exception.dart';
import 'package:shopping/utils/constants.dart';
import 'package:shopping/utils/environment_variables.dart';

class Auth with ChangeNotifier {
  final _dio = Dio(BaseOptions(
    receiveDataWhenStatusError: true,
    baseUrl: Constants.AUTH_BASE_URL,
    validateStatus: (status) => true,
  ));

  final _apiKey = dotenv.env[EnvironmentConfig.API_KEY];

  final String _singUpURl = 'signUp?key=';
  final String _loginURl = 'signInWithPassword?key=';

  String _token = '';
  String _userId = '';

  DateTime? _expiresIn;
  Timer? _logoutTimer;

  String get token {
    return _token;
  }

  String get userId {
    return _userId;
  }

  DateTime? get expiresIn {
    return _expiresIn;
  }

  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout() {
    _clearLogoutTimer();

    int time = expiresIn!.difference(DateTime.now()).inSeconds;

    _logoutTimer = Timer(
      Duration(seconds: time),
      () => logout(),
    );
  }

  Future<void> _authenticator(String email, String password, String url) async {
    Response response = await _dio.post(
      '$url$_apiKey',
      data: {'email': email, 'password': password, 'returnSecureToken': true},
    );

    if (response.data['error'] != null) {
      throw AuthException(key: response.data['error']['message']);
    }
    _token = response.data['idToken'];
    _userId = response.data['localId'];

    _expiresIn = DateTime.now()
        .add(Duration(seconds: int.parse(response.data['expiresIn'])));

    _autoLogout();

    Store.saveMap('auth', {
      'token': _token,
      'userId': _userId,
      'expiresIn': _expiresIn!.toIso8601String(),
    });

    notifyListeners();
  }

  Future<void> singUp(String email, String password) async {
    await _authenticator(email, password, _singUpURl);
  }

  Future<void> login(String email, String password) async {
    await _authenticator(email, password, _loginURl);
  }

  Future<void> tryAutoLogin() async {
    if (_token.isNotEmpty) return;
    Map<String, dynamic> data = await Store.getMap('auth');

    if (data.isEmpty) return;

    DateTime date = DateTime.parse(data['expiresIn']);

    if (date.isBefore(DateTime.now())) return;

    _token = data['token'];
    _userId = data['userId'];
    _expiresIn = DateTime.parse(data['expiresIn']);

    _autoLogout();
  }

  void logout() {
    _expiresIn = null;
    _token = '';
    _userId = '';
    _clearLogoutTimer();
    Store.clear().then(
      (_) {
        notifyListeners();
      },
    );
  }
}
