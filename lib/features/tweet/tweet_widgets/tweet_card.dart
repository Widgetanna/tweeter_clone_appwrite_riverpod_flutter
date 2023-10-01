import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tweeter_clone_flutter/commun/commun.dart';
import 'package:tweeter_clone_flutter/core/enum.dart';
import 'package:tweeter_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:tweeter_clone_flutter/features/tweet/hashtags/hastags.dart';
import 'package:tweeter_clone_flutter/features/tweet/tweet_controller/tweet_controller.dart';
import 'package:tweeter_clone_flutter/features/tweet/tweet_widgets/caroussel_image.dart';
import 'package:tweeter_clone_flutter/features/tweet/tweet_widgets/icone_button_twitter.dart';
import 'package:tweeter_clone_flutter/model/tweeter_model.dart';

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({
    super.key,
    required this.tweet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve the current user details
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return currentUser == null
        ? const SizedBox()
        : ref.watch(userDetailsProvider(tweet.uid)).when(
              data: (user) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to tweet details screen
                    // Navigator.push(
                    //   context,
                    //   TwitterReplyScreen.route(tweet),
                    // );
                  },
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to user profile screen
                                // Navigator.push(
                                //   context,
                                //   UserProfileView.route(user),
                                // );
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(user.profilePic),
                                radius: 35,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (tweet.retweetedBy.isNotEmpty)
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.repeat_sharp,
                                        color: Pallete.blueColor,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${tweet.retweetedBy} retweeted',
                                        style: const TextStyle(
                                          color: Pallete.greyColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: user.isTwitterBlue ? 1 : 5,
                                      ),
                                      child: Text(
                                       currentUser.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '@${currentUser.name} · ${timeago.format(
                                        tweet.tweetedAt ?? DateTime.now(),
                                        locale: 'en_short',
                                      )} · ${tweet.tweetedAt != null ? DateFormat('MMM dd, yyyy HH:mm').format(tweet.tweetedAt!) : ''}',
                                      style: const TextStyle(
                                        color: Pallete.greyColor,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                if (tweet.repliedTo.isNotEmpty)
                                  ref
                                      .watch(
                                          getTweetByIdProvider(tweet.repliedTo))
                                      .when(
                                        data: (repliedToTweet) {
                                          final replyingToUser = ref
                                              .watch(
                                                userDetailsProvider(
                                                  repliedToTweet.uid,
                                                ),
                                              )
                                              .value;
                                          return RichText(
                                            text: TextSpan(
                                              text: 'Replying to',
                                              style: const TextStyle(
                                                color: Pallete.greyColor,
                                                fontSize: 16,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      ' @${replyingToUser?.name}',
                                                  style: const TextStyle(
                                                    color: Pallete.blueColor,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        error: (error, st) => ErrorText(
                                          error: error.toString(),
                               ),
                                        loading: () => const SizedBox(),
                                      ),
                                // Hashtag
                                
                          HashtagText(text: tweet.text),
                          if (tweet.tweetType == TweetType.image)
                           CarouselImage (
                              imageLinks: tweet.imageLinks,
                            ),
                          if (tweet.link.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            AnyLinkPreview(
                              displayDirection:
                                  UIDirection.uiDirectionHorizontal,
                              link: tweet.link.startsWith('http://') ||
                                      tweet.link.startsWith('https://')
                                  ? tweet.link
                                  : 'https://${tweet.link}',
                              //key: UniqueKey(),
                            ),
                              ],
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    right: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Favorites
                                      IconButtonTweeter(
                                        iconData: Icons.favorite,
                                        text: (tweet.commentIds.length +
                                                tweet.reshareCount +
                                                tweet.likes.length)
                                            .toString(),
                                        onTap: () {},
                                      ),
                                      // Comments
                                      IconButtonTweeter(
                                        iconData: Icons.comment,
                                        text: (tweet.commentIds.length).toString(),
                                        onTap: () {},
                                      ),
                                      // Retweet
                                      IconButtonTweeter(
                                        iconData: Icons.repeat_sharp,
                                        text: (tweet.reshareCount).toString(),
                                        onTap: () {
                                          ref
                                              .read(
                                                  tweetControllerProvider.notifier)
                                              .reshareTweet(
                                                  tweet, currentUser, context);
                                        },
                                      ),
                                      // Like button
                                      LikeButton(
                                        size: 25,
                                        onTap: (isLiked) async {
                                          ref
                                              .read(
                                                  tweetControllerProvider.notifier)
                                              .likeTweet(tweet, currentUser);
                                          return !isLiked;
                                        },
                                        // Show favorite in red
                                        isLiked:
                                            tweet.likes.contains(currentUser.uid),
                                        likeBuilder: (bool isLiked) {
                                          return Icon(
                                            isLiked
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isLiked
                                                ? Pallete.redColor
                                                : Pallete.greyColor,
                                            size: 25,
                                          );
                                        },
                                        likeCount: tweet.likes.length,
                                        countBuilder: ((likeCount, isLiked, text) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(left: 2.0),
                                            child: Text(
                                              text,
                                              style: TextStyle(
                                                color: isLiked
                                                    ? Pallete.redColor
                                                    : Pallete.greyColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.share_outlined,
                                          size: 25,
                                          color: Pallete.greyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 1),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Pallete.greyColor),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
              loading: () => const Loader(),
            );
  }
}
