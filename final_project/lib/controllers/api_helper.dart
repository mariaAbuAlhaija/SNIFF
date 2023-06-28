import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiHelper {
  String domain = "192.168.1.104:3333";
  Future get(String path, {body}) async {
    Uri uri = Uri.http(domain, path, body);
    var token = await getToken();
    var headers = {"Authorization": token};
    var response = await http.get(uri, headers: headers);
    return responsing(response);
  }

  Future post(String path, {body}) async {
    Uri uri = Uri.http(domain, path);
    var response = await http.post(uri, body: body);
    return responsing(response);
  }

  Future postAuth(String path, {Map<String, dynamic>? body}) async {
    Uri uri = Uri.http(domain, path);

    var token = await getToken();
    var headers = {"Authorization": token};
    var response = await http.post(uri, body: body, headers: headers);
    return responsing(response);
  }

  Future put(String path, Map body) async {
    Uri uri = Uri.http(domain, path);
    var response = await http.put(uri, body: body);
    return responsing(response);
  }

  Future delete(String path) async {
    Uri uri = Uri.http(domain, path);
    var response = await http.delete(uri);
    return responsing(response);
  }

  Future<String> getToken() async {
    var storage = FlutterSecureStorage();
    String result = await storage.read(key: "token") as String;
    return result;
  }

  responsing(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonObject = jsonDecode(response.body);
        return jsonObject;
      case 400:
        throw "${response.statusCode}: Bad Request\nResponse Body\n${response.body}";
      case 401:
        throw "${response.statusCode}: Unauthrizied\nResponse Body\n${response.body}";
      case 402:
        throw "${response.statusCode}: Payment Required\nResponse Body\n${response.body}";
      case 403:
        throw "${response.statusCode}: Forbidden\nResponse Body\n${response.body}";
      case 404:
        throw "${response.statusCode}: Not Found\nResponse Body\n${response.body}";
      case 500:
        throw "${response.statusCode}: Server Error :(\nResponse Body\n${response.body}";
      default:
        throw "${response.statusCode}: Server Error :(\nResponse Body\n${response.body}";
    }
  }
}
