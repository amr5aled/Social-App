import 'dart:ui';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociaapp/layout/socialApp/cubit/socialCubit.dart';
import 'package:sociaapp/layout/socialApp/cubit/socialState.dart';
import 'package:sociaapp/models/Posts.dart';
import 'package:sociaapp/shared/styles/colors.dart';
import 'package:sociaapp/shared/styles/icon_broken.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).model != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: EdgeInsets.all(
                    8.0,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                          'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                        ),
                        fit: BoxFit.cover,
                        height: 180.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'communicate with friends',
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildPosts(
                        SocialCubit.get(context).posts[index], context, index);
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.0,
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPosts(
    PostsModel post,
    context,
    int index,
  ) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 65,
                height: 50,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                    '${post.image}',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${post.userName}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(height: 1.4),
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      '${post.date}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(height: 1.7),
                    ),
                  ],
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  size: 16.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[100],
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              '${post.text}',
              maxLines: 5,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(3.0),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       direction: Axis.horizontal,
          //       children: [
          //         Container(
          //             height: 28.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software',
          //                 style: Theme.of(context).textTheme.caption.copyWith(
          //                       color: defaultColor,
          //                     ),
          //               ),
          //             )),
          //         Container(
          //             height: 28.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#flutter',
          //                 style: Theme.of(context).textTheme.caption.copyWith(
          //                       color: defaultColor,
          //                     ),
          //               ),
          //             )),
          //         Container(
          //             height: 28.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software',
          //                 style: Theme.of(context).textTheme.caption.copyWith(
          //                       color: defaultColor,
          //                     ),
          //               ),
          //             )),
          //       ],
          //     ),
          //   ),
          // ),
          if (post.imagepost != '')
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Card(
                child: Container(
                  width: double.infinity,
                  height: 140,
                  child: Image.network(
                    '${post.imagepost}',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '${SocialCubit.get(context).likes[index]}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Chat,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            '${SocialCubit.get(context).comments[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[100],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () {
                SocialCubit.get(context)
                    .CommentPost(path: SocialCubit.get(context).postId[index]);
              },
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 15.0,
                      backgroundImage: NetworkImage(
                        '${SocialCubit.get(context).model.image}',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    'write a comment ...',
                    style: Theme.of(context).textTheme.caption.copyWith(),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).likePost(
                          path: SocialCubit.get(context).postId[index]);
                    },
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
