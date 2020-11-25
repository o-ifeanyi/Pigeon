import 'dart:convert';

import 'package:Pigeon/src/data/models/custom_error.dart';
import 'package:Pigeon/src/data/models/user.dart';
import 'package:Pigeon/src/utils/custom_http_client.dart';
import 'package:Pigeon/src/utils/custom_shared_preferences.dart';
import 'package:Pigeon/src/utils/my_urls.dart';

class OTPRepository {
  CustomHttpClient http = CustomHttpClient();

  Future<dynamic> otp(String otp, String token) async {
    try {
      var header = {'token': token};
      var body = jsonEncode({'otp': otp});
      var response = await http.post(
        '${MyUrls.serverUrl}/auth',
        headers: header,
        body: body,
      );
      final dynamic otpResponse = jsonDecode(response.body);

      if (otpResponse['error'] != null) {
        return CustomError.fromJson(otpResponse);
      }
      await CustomSharedPreferences.setString('token', otpResponse['token']);
      final User user = User.fromJson(otpResponse['user']);
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
