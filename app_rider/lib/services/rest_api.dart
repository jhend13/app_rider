import 'package:app_rider/config/constants.dart' as constants;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_rider/models/user.dart';

class RestApiService {
  static Future<User> createAndSyncUser(User user, String name) async {
    try {
      final uri = Uri.parse(constants.urlRestApiCreateUser);
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'firebase_uid': user.uid!,
            'name': name,
          }));

      final result = jsonDecode(response.body) as Map<String, dynamic>;

      if (result.isNotEmpty && response.statusCode == 200) {
        user.syncFromJSON(result);
      } else {
        throw Exception('API request failed.');
      }

      return user;
    } catch (e) {
      return Future.error(e);
    }
  }
}
