import 'package:http/http.dart' as http;

class HttpUtils {
  Future<http.Response> post(String url, Map<String, dynamic> params) async {
    return http.post(Uri.parse(url), body: params);
  }
}
