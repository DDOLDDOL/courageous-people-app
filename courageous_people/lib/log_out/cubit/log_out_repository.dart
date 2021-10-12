import 'package:courageous_people/common/hive/user_hive.dart';
import 'package:courageous_people/utils/http_client.dart';
import 'package:http/http.dart' as http;

import '../../service/token_service.dart';

class LogOutRepository {
  const LogOutRepository();

  Future<bool> logOut() async {
    final response = await httpRequestWithToken(
      requestType: 'POST',
      path: '/account/logout',
      body: {
        "refresh": TokenService().refreshToken,
      },
    );

    if(response.statusCode == 205) {
      await TokenService().setTokens('', '');
      await UserHive().setEmail('');
      await UserHive().setId(-1);

      return true;
    }

    return false;
  }
}