import 'package:spotify_app/data/models/auth/create_user_req.dart';
import 'package:spotify_app/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_app/domain/repository/auth/auth.dart';
import 'package:spotify_app/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(CreateUserReq createUserReq) async {
    await sl<AuthFirebaseService>().signUp(createUserReq);
  }
}
