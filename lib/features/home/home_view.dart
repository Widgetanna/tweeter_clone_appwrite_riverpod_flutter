import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweeter_clone_flutter/commun/pallette.dart';
import 'package:tweeter_clone_flutter/constantes/ui_const.dart';
import 'package:tweeter_clone_flutter/features/tweet/tweet_view/tweet_view.dart';


class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  final AppBar appBar = UIConstants.appBar();

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  onCreateTweet() {
    Navigator.push(context, CreateTweetScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _page == 0 ? appBar : null,
      //pour maintenir state
      body: IndexedStack(
        index: _page,
        children: UIConstants.bottomTabBarPages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateTweet,
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 28,
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Pallete.backgroundColor,
        currentIndex: _page,
        onTap: onPageChange,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _page == 0 ? Icons.home_rounded : Icons.home_outlined,
              color: Pallete.whiteColor,
            ),
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Pallete.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _page == 2
                  ? Icons.notifications
                  : Icons.notifications_none_outlined,
              color: Pallete.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
