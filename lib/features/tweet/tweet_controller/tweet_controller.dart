import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tweeter_clone_flutter/apis/storage_api.dart';
import 'package:tweeter_clone_flutter/apis/tweet_api.dart';
import 'package:tweeter_clone_flutter/core/enum.dart';
import 'package:tweeter_clone_flutter/core/utils.dart';
import 'package:tweeter_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:tweeter_clone_flutter/model/model_user.dart';
import 'package:tweeter_clone_flutter/model/tweeter_model.dart';


final tweetControllerProvider = StateNotifierProvider<TweetController, bool>(
  (ref) {
    return TweetController(
      ref: ref,
      tweetApi: ref.watch(tweetAPIProvider),
      storageApi: ref.watch(storageAPIProvider),
      //notificationController:
       //  ref.watch(notificationControllerProvider.notifier),
    );
  },
);

final getTweetsProvider = FutureProvider((ref) {
  final tweetController = ref.watch(tweetControllerProvider.notifier);
  return tweetController.getTweets();
});

//on peut ajouter .autoDispose
final getLatestTweetProvider = StreamProvider((ref) {
  final tweetApi = ref.watch(tweetAPIProvider);
  return tweetApi.getLatestTweet();
});

final getTweetByIdProvider = FutureProvider.family((ref, String id) async {
  final tweetController = ref.watch(tweetControllerProvider.notifier);
  return tweetController.getTweetById(id);
});

class TweetController extends StateNotifier<bool> {
  //pour pouvour obtenir id dans void _shareTextTweet obtenir Ref de constructeur
  //ça peut être n'importe quel ref (widget, provider ref ...)
  final Ref _ref;
  final TweetAPI _tweetApi;
  final StorageAPI _storageApi;
  TweetController({
    required TweetAPI tweetApi,
    required Ref ref,
    required StorageAPI storageApi,
  }) : _ref = ref, 
       _tweetApi = tweetApi,
       _storageApi = storageApi,
  super(false);

  //convertir tweets en format liste 
 Future<List<Tweet>> getTweets() async {
    final tweetList = await _tweetApi.getTweets();
    //on convert en model
    return tweetList.map((tweet) => Tweet.fromMap(tweet.data)).toList();
  }

  Future<Tweet> getTweetById(String id) async {
    final tweet = await _tweetApi.getTweetById(id);
    return Tweet.fromMap(tweet.data);
  }

  void likeTweet(Tweet tweet, UserModel user) async {
    List<String> likes = tweet.likes;
    if(tweet.likes.contains(user.uid) ) {
      likes.remove(user.uid);
    } else {
      likes.add(user.uid);
    }
    tweet = tweet.copyWith(
      likes: likes
    );
    final res = await _tweetApi.likeTweet(tweet);
    res.fold((l) => null, (r) => null);
  }

  void reshareTweet (
  Tweet tweet, 
  UserModel currentUser,
  //pour pouvoir afficher erreur au cas d'erreur
  BuildContext context) async {
  tweet = tweet.copyWith(
  retweetedBy: currentUser.name,
  likes: [],
  commentIds: [],
  reshareCount: tweet.reshareCount +1,
);

final res = await _tweetApi.updateReshareCount(tweet);
    res.fold((l) => showSnackBar(
      context, l.message), (r) async{
        tweet = tweet.copyWith(
          id: ID.unique(),
          reshareCount: 0,
          tweetedAt: DateTime.now(),
        );
       final res2 = await _tweetApi.shareTweet(tweet);
        res2.fold((l) => showSnackBar( context, l.message), (r) =>showSnackBar( context, 'Retweeted'));
      });
   }

//il va être envoyé en dehors de controller
    void shareTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
    required String repliedTo,
   }) {
    if (text.isEmpty) {
      // showSnackBar deprecié, nouvelle maniere à verifier:
      //showSnackBar (content: Text("EPlease enter text"));
       showSnackBar(context, 'Please enter text');
      return;
    }

    if (images.isNotEmpty) {
      _shareImageTweet(
        images: images,
        text: text,
        context: context,
        repliedTo: repliedTo,
       
      );
    } else {
      _shareTextTweet(
        text: text,
        context: context,
        repliedTo: repliedTo,
        
      );
    }
  }

  void _shareImageTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
    required String repliedTo,
  }) async {
    state = true;
    final hashtags = _getHashtagsFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    String link = _getLinkFromText(text);
    final imageLinks = await _storageApi.uploadImage(images);
    Tweet tweet = Tweet(
      text: text,
      hashtags: hashtags,
      link: link,
      imageLinks: imageLinks,
      uid: user.uid,
      tweetType: TweetType.image,
      tweetedAt: DateTime.now(),
      likes: const [],
      commentIds: const [],
      id: "",
      reshareCount: 0,
      retweetedBy: "",
      repliedTo: repliedTo,
    );
    final res = await _tweetApi.shareTweet(tweet);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  void _shareTextTweet({
    required String text,
    required BuildContext context,
    required String repliedTo,
  }) async {
    state = true;
    final hashtags = _getHashtagsFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    String link = _getLinkFromText(text);
    Tweet tweet = Tweet(
      text: text,
      hashtags: hashtags,
      link: link,
      imageLinks: const [],
      uid: user.uid,
      tweetType: TweetType.text,
      tweetedAt: DateTime.now(),
      likes: const [],
      commentIds: const [],
      id: "",
      reshareCount: 0,
      retweetedBy: "",
      repliedTo: repliedTo,
    );
    final res = await _tweetApi.shareTweet(tweet);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

String _getLinkFromText(String text){
    String link = "";
  List<String> wordsInSentence = text.split(" ");
  //verification si c'est un link
for (String word in wordsInSentence) {
        if (word.startsWith("https://") || word.startsWith("www.")) {
        link = word;
      }
    }
    return link;
  }
  //pour #
 List<String> _getHashtagsFromText(String text) {
  List<String> hashtags = [];
   List<String> wordsInSentence = text.split(" ");
  //verification si c'est un link
for (String word in wordsInSentence) {
     if (word.startsWith("#")) {
        hashtags.add(word);
      }
    }
    return  hashtags ;
 }

  

 }