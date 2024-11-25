import 'package:app_rider/config/constants.dart' as constants;
import 'package:app_rider/services/api/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_rider/models/user.dart';

class RestApiService implements HttpAPI {
  /* 
    takes a user object with a firebase UID and
    queries the restAPI server for the user info that is stored
    in that database
    */
  static Future<User> syncUser(User user) async {
    try {
      final uid = user.uid;

      final uri = Uri.http(constants.uriRestApiReadUserAuthority,
          constants.uriRestApiReadUserPath, {'uid': user.uid});

      final response = await http.get(uri);
      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json.isNotEmpty && response.statusCode == 200) {
        user.syncFromJSON(json);
      } else {
        throw Exception('API request failed.');
      }

      return user;
    } catch (e) {
      return Future.error(e);
    }
  }

  /* 
    called after a firebase user is created
    takes a user object with a firebase UID and
    queries the restAPI server for the user info that is stored
    in that database
    */
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
