import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociaapp/layout/socialApp/cubit/socialCubit.dart';
import 'package:sociaapp/layout/socialApp/cubit/socialState.dart';
import 'package:sociaapp/models/message.dart';
import 'package:sociaapp/models/registermodel.dart';
import 'package:sociaapp/shared/styles/colors.dart';
import 'package:sociaapp/shared/styles/icon_broken.dart';

class ChatDetails extends StatelessWidget {
  RegisterModel model;
  ChatDetails({this.model});
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getMessage(
        receiveId: model.uid,
      );

      return BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        model.image,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      model.userName,
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: true,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).messages[index];

                              if (SocialCubit.get(context).model.uid ==
                                  message.senderId)
                                return buildMyMessage(message);
                              return buildMessage(message);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 15.0);
                            },
                            itemCount: cubit.messages.length),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey[300], width: 1.0),
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  controller: textController,
                                  decoration: InputDecoration(
                                    hintText: 'Type your message',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              decoration: BoxDecoration(color: Colors.blue),
                              child: MaterialButton(
                                onPressed: () {
                                  cubit.sendMessage(
                                      data: DateTime.now().toString(),
                                      receiveId: model.uid,
                                      text: textController.text);
                                  textController.clear();
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  IconBroken.Send,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          });
    });
  }

  Widget buildMyMessage(MessageModel message) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: defaultColor.withOpacity(
            .2,
          ),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(
              10.0,
            ),
            topStart: Radius.circular(
              10.0,
            ),
            topEnd: Radius.circular(
              10.0,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(
          '${message.text}',
        ),
      ),
    );
  }

  Widget buildMessage(MessageModel message) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(
              10.0,
            ),
            topStart: Radius.circular(
              10.0,
            ),
            topEnd: Radius.circular(
              10.0,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(
          '${message.text}',
        ),
      ),
    );
  }
}
