import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociaapp/layout/socialApp/cubit/socialCubit.dart';
import 'package:sociaapp/layout/socialApp/cubit/socialState.dart';
import 'package:sociaapp/modules/edit_profile/edit_profile.dart';
import 'package:sociaapp/shared/components/component.dart';
import 'package:sociaapp/shared/styles/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context).model;
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 175,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            child: Image.network('${cubit.cover}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 64.0,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: NetworkImage(
                              '${cubit.image}',),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '${cubit.userName}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  '${cubit.bio}',
                  style: Theme.of(context).textTheme.caption,
                ),


                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100',style: Theme.of(context).textTheme.subtitle2,),
                            Text('Posts',style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100',style: Theme.of(context).textTheme.subtitle2,),
                            Text('Photos',style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('10k',style: Theme.of(context).textTheme.subtitle2,),
                            Text('Followers',style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('10K',style: Theme.of(context).textTheme.subtitle2,),
                            Text('Followings',style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          child: Text('Add Photos'),
                          onPressed: () {
                            // message().then((value) => print('hekko'));
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          navigateto(context, EditProfile());
                        },
                        label: Text('EditProfile'),
                        icon: Icon(IconBroken.Edit),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
  // Future <void>message()async
  // {
  //  await FirebaseMessaging.instance.subscribeToTopic('weather');
  // }
}
