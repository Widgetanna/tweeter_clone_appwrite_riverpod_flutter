import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tweeter_clone_flutter/apis/auth_api.dart';
import 'package:tweeter_clone_flutter/apis/user_api.dart';
import 'package:tweeter_clone_flutter/core/core.dart';
import 'package:tweeter_clone_flutter/features/auth/view/login_view.dart';
import 'package:tweeter_clone_flutter/features/home/home_view.dart';
import 'package:appwrite/models.dart' as model;
import 'package:tweeter_clone_flutter/model/model_user.dart';


final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

//pour la condition d'affichage login signup view
final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});
//pur recuperer tweet et voir autor de tweet
final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

  final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});


class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({
    required AuthAPI authAPI,
    required UserAPI userAPI,
  })  : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);
  // state = isLoading


//pour la condition d'affichage login signup view
 Future<model.Account?> currentUser() => _authAPI.currentUserAccount();

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
      (r) async {
        UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          followers: [],
          following: [],
          profilePic: "",
          bannerPic: "",
          //pour me^me id dans auth et database
          uid: r.$id,
          bio: "",
          isTwitterBlue: false,
        );
     final res2 = await _userAPI.saveUserData(userModel);
        res2.fold((l) => showSnackBar(context, l.message), (r) {
          showSnackBar(context, 'Accounted created! Please login.');
          Navigator.push(context, LogginView.route());
        });
      },
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
//recup tweet de database
  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }
}
