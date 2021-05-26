import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociaapp/modules/chats/chats.dart';
import 'package:sociaapp/modules/feeds/feeds.dart';
import 'package:sociaapp/modules/posts/posts.dart';
import 'package:sociaapp/modules/setting/setting.dart';
import 'package:sociaapp/modules/users/users.dart';
import 'package:sociaapp/shared/components/component.dart';
import 'package:sociaapp/shared/styles/icon_broken.dart';

import 'cubit/socialCubit.dart';
import 'cubit/socialState.dart';

class SocialHome extends StatelessWidget {
  List<Widget> screens = [
    FeedScreen(),
    ChatScreen(),
    Posts(),
    UserScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is CreatePostsState) {
          navigateto(context, Posts());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    IconBroken.Notification,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    IconBroken.Search,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Home,
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Chat,
                  ),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Paper_Upload,
                  ),
                  label: 'posts',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Location,
                    ),
                    label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting), label: 'Setting'),
              ],
            ),
            body: screens[cubit.currentIndex]);
      },
    );
  }
}
