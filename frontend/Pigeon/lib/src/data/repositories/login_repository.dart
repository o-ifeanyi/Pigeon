import 'dart:convert';

import 'package:Pigeon/src/data/models/custom_error.dart';
import 'package:Pigeon/src/data/models/user.dart';
import 'package:Pigeon/src/utils/custom_http_client.dart';
import 'package:Pigeon/src/utils/custom_shared_preferences.dart';
import 'package:Pigeon/src/utils/my_urls.dart';

class LoginRepository {
  CustomHttpClient http = CustomHttpClient();

  Future<dynamic> login(String phoneNo) async {
    try {
      var body = jsonEncode({'phone': phoneNo});
      var response = await http.post(
        '${MyUrls.serverUrl}/auth',
        body: body,
      );
      final dynamic loginResponse = jsonDecode(response.body);

      if (loginResponse['error'] != null) {
        return CustomError.fromJson(loginResponse);
      }
      await CustomSharedPreferences.setString('token', loginResponse['token']);
      final User user = User.fromJson(loginResponse['user']);
      print("user : hello >>>");
      print(user);
      await CustomSharedPreferences.setString('user', user.toString());
      return user;
    } catch (err) {
      return CustomError(
        error: true,
        errorMessage: "An error has occurred! Try again",
      );
    }
  }
}
