
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tweeter_clone_flutter/commun/commun.dart';
import 'package:tweeter_clone_flutter/core/core.dart';

import 'package:tweeter_clone_flutter/features/auth/controller/auth_controller.dart';
import 'dart:io' as io;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tweeter_clone_flutter/features/tweet/tweet_controller/tweet_controller.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  
  static route() => MaterialPageRoute(
        builder: (context) => const CreateTweetScreen(),
      );
  const CreateTweetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  final tweetTextController = TextEditingController();
   List<io.File> images = [];

   @override
  void dispose() {
    super.dispose();
    tweetTextController.dispose();
  }
void shareTweet() {
  final tweetController = ref.read(tweetControllerProvider.notifier);
  tweetController.shareTweet(
    images: images,
    text: tweetTextController.text,
    context: context,
    repliedTo: "",
  );
  print("tweet: ${tweetTextController.text}");
  Navigator.pop(context);
}
//attention emplacement
void onPickImages() async {
    images = await pickImages();
    setState(() {});
  }
 

  @override
  Widget build(BuildContext context) {
   final currentUser = ref.watch(currentUserDetailsProvider).value;
    //final appwriteClient = ref.watch(appwriteClientProvider);
        print("+++current user is ${currentUser?.name}");
       
    final isLoading = ref.watch(tweetControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, size: 30),
        ),
        actions: [
        ButtonWidget(
              onTap: shareTweet,
            label: 'Tweet',
            backgroundColor: Pallete.blueColor,
            textColor: Pallete.whiteColor,
          ),
        ],
      ),
      body: 
      isLoading || 
      currentUser == null
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                           NetworkImage(currentUser.profilePic),
                          radius: 30,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextField(
                            controller: tweetTextController,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                            decoration: const InputDecoration(
                              hintText: "What's happening?",
                              hintStyle: TextStyle(
                                color: Pallete.greyColor,
                                 fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              border: InputBorder.none,
                            ),
                            //pour aller à la ligne 
                            maxLines: null,
                          ),
                        ),
                      ],
                    ),
                    
                    if (images.isNotEmpty)
                      CarouselSlider(
                        items: images.map(
                          (file) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                               child: Image.file(file),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          height: 400,
                          enableInfiniteScroll: false,
                        ),
                      ),
                      
                  ],
                ),
              ),
            ),
      bottomNavigationBar: 
      Container(
        padding: const EdgeInsets.only(bottom: 50),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Pallete.greyColor,
              width: 0.3,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: GestureDetector(
               onTap: onPickImages,
                child: const Icon(
                  Icons.photo_library_sharp,
                  color: Pallete.blueColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: const Icon(
                Icons.gif_box_rounded,
                color: Pallete.blueColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: const Icon(
                Icons.emoji_emotions_rounded,
                color: Pallete.blueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
