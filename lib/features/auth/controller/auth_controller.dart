import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tweeter_clone_flutter/apis/auth_api.dart';
import 'package:tweeter_clone_flutter/core/core.dart';
import 'package:tweeter_clone_flutter/home/home_view.dart';



final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
   
  );
});



class AuthController extends StateNotifier<bool> {
  //bool car on veut ajouter is Loading
  final AuthAPI _authAPI;

  AuthController({required AuthAPI authAPI})
      : _authAPI = authAPI,
        super(false);
//quand utilisateur créée son compte
  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email, 
      password: password);
       state = false;
       res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => print (r.email),
      /*
      async {
        UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          followers: [],
          following: [],
          profilePic: "",
          bannerPic: "",
          uid: "",
          bio: "",
          isTwitterBlue: false,
        );
        
      },*/
    );
  }

   void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.login(
      email: email,
      password: password,
    );
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
       Navigator.push(context, HomeView.route());
      },
    );
  }
}
