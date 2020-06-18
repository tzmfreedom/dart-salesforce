import 'dart:convert';

import 'package:http/http.dart' as http;

import 'src/objects.dart';

class Client {
  http.Client client;
  String loginUrl;
  String instanceUrl;
  String apiVersion;
  String clientId;
  String clientSecret;
  String accessToken;

  Client({ this.loginUrl, this.apiVersion, this.clientId, this.clientSecret }) {
    this.client = http.Client();
  }

  authorize(String username, String password) async {
    final r = await this.client.post(
        buildTokenUrl,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'password',
          'client_id': clientId,
          'client_secret': clientSecret,
          'username': username,
          'password': password,
        }
    );
    final Map<String, dynamic> res = jsonDecode(r.body);
    this.accessToken = res['access_token'];
    this.instanceUrl = res['instance_url'];
  }

  Future<Map<String, dynamic>> get(String path) async {
    final r = await client.get(buildUrl(path), headers: {
      'Authorization': 'Bearer $accessToken',
    });
    return jsonDecode(r.body);
  }

  Future<Map<String, dynamic>> post(String path) async {
    final r = await client.post(buildUrl(path), headers: {
      'Authorization': 'Bearer $accessToken',
    });
    return jsonDecode(r.body);
  }

  Future<Map<String, dynamic>> put(String path) async {
    final r = await client.put(buildUrl(path), headers: {
      'Authorization': 'Bearer $accessToken',
    });
    return jsonDecode(r.body);
  }

  Future<Map<String, dynamic>> patch(String path) async {
    final r = await client.patch(buildUrl(path), headers: {
      'Authorization': 'Bearer $accessToken',
    });
    return jsonDecode(r.body);
  }

  Future<Map<String, dynamic>> delete(String path) async {
    final r = await client.delete(buildUrl(path), headers: {
      'Authorization': 'Bearer $accessToken',
    });
    return jsonDecode(r.body);
  }

  Future<QueryResponse> query(String q) async {
    final r = await get("/query/?q=$q");
    return QueryResponse.fromJson(r);
  }

  Future<QueryResponse> queryMore(String path) async {
    final r = await get(path);
    return QueryResponse.fromJson(r);
  }

  createSObject() {

  }

  updateSObject() {

  }

  buildUrl(String path) {
    return "$instanceUrl/services/data/$apiVersion$path";
  }

  buildTokenUrl() {
    return "https://$loginUrl/services/oauth2/token";
  }
}
