import 'package:googleapis_auth/auth_io.dart';

class GetServerkey {
  Future<String> getServerskey() async {
    final scope = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({}), scope);
    final accesServerkey = client.credentials.accessToken.data;
    return accesServerkey;
  }
}
