import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tweeter_clone_flutter/apis/user_api.dart';
import 'package:tweeter_clone_flutter/model/model_user.dart';

final ExploreControllerProvider = StateNotifierProvider((ref) {
  return ExploreController(userAPI: ref.watch(userAPIProvider),
  );
  });

final serchUserProvider = FutureProvider.family((ref, String name) async {
final ExploreController = ref.watch(ExploreControllerProvider.notifier);
return ExploreController.serchUser(name);
});

class ExploreController extends StateNotifier<bool> {
  final UserAPI _userAPI;
ExploreController({
  required UserAPI userAPI,
}): 
 _userAPI = userAPI,
super(false);

Future<List<UserModel>> serchUser(String name) async {
final users = await _userAPI.searchUserByName(name);
return users.map((e) => UserModel.fromMap(e.data)).toList();
}
}