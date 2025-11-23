import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_app/data/models/auth/create_user_req.dart';
import 'package:spotify_app/data/models/auth/signin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signUp(CreateUserReq createUserReq);
  Future<Either> signIn(SigninUserReq signinUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signIn(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserReq.email,
        password: signinUserReq.password,
      );

      return Right('Sign in berhasil');
    } on FirebaseAuthException catch (err) {
      String message = '';

      if (err.code == 'invalid-email') {
        message = 'Email yang anda masukkan salah';
      } else if (err.code == 'invalid-credentials') {
        message = 'Password yang anda masukkan salah';
      }

      return Left(message);
    }
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      return Right('Sign Up was successfull');
    } on FirebaseAuthException catch (err) {
      String message = '';

      if (err.code == 'weak-password') {
        message = 'Password yang digunakan terlalu mudah';
      } else if (err.code == 'email-already-in-use') {
        message = 'Email yang anda masukkan sudah digunakan';
      }

      return Left(message);
    }
  }
}
