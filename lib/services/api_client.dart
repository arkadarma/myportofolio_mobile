import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  ApiClient({http.Client? client, this.baseUrl = apiBaseUrl})
    : _client = client ?? http.Client();

  static const _timeout = Duration(seconds: 15);
  static const _projectPath = '/api/v1/projects/';
  static const _acceptJson = {'Accept': 'application/json'};
  static const _jsonHeaders = {
    ..._acceptJson,
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final http.Client _client;
  final String baseUrl;

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  Future<List<Project>> getProjects() async {
    final response = await _client
        .get(_uri(_projectPath), headers: _acceptJson)
        .timeout(_timeout);
    _ensureSuccess(response);
    final decoded =
        jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    return decoded
        .map((item) => Project.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Project> createProject(
    Project project, {
    required String token,
  }) async {
    final response = await _client
        .post(
          _uri(_projectPath),
          headers: {..._jsonHeaders, 'Authorization': 'Token $token'},
          body: jsonEncode(project.toJson()),
        )
        .timeout(_timeout);
    _ensureSuccess(response);
    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    return Project.fromJson(decoded as Map<String, dynamic>);
  }

  Future<String> obtainToken(String username, String password) async {
    final response = await _client
        .post(
          _uri('/api/v1/auth/token/'),
          headers: _jsonHeaders,
          body: jsonEncode({'username': username, 'password': password}),
        )
        .timeout(_timeout);
    _ensureSuccess(response);
    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded case {'token': final String token} when token.isNotEmpty) {
      return token;
    }
    throw const FormatException('Missing authentication token.');
  }

  Future<void> logout({required String token}) async {
    final response = await _client
        .post(
          _uri('/api/v1/auth/logout/'),
          headers: {..._acceptJson, 'Authorization': 'Token $token'},
        )
        .timeout(_timeout);
    _ensureSuccess(response);
  }

  void _ensureSuccess(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(response.statusCode, response.body);
    }
  }
}
