import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociaapp/layout/socialApp/cubit/socialCubit.dart';
import 'package:sociaapp/layout/socialApp/cubit/socialState.dart';
import 'package:sociaapp/shared/components/component.dart';
import 'package:sociaapp/shared/styles/icon_broken.dart';

class Posts extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {
          if(state is SocialSucessState)
            {
              defaultMessage(message: 'Posted is Created');
            }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar:
                defaultAppBar(context: context, title: 'CreatePost', actions: [
              defaultTextButton(function: () {
                if(cubit.imagePost!=null)
                  {
                    cubit.putImagePost(text: textController.text,date: DateTime.now().toString());
                  }
                else{
                  cubit.createPosts(text: textController.text,date: DateTime.now().toString());
                }
              }, text: 'Post'),
            ]),
            body: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
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
                            '${SocialCubit.get(context).model.image}',
                          ),
                        ),
                      ),
                      Text(
                        'Amr Khaled',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'What is your mind....',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                ),
                if(cubit.imagePost!=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                4.0,
                              ),
                              topRight: Radius.circular(
                                4.0,
                              ),
                            ),
                            image: DecorationImage(
                              image:
                                  FileImage(cubit.imagePost),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                            radius: 18,
                            child: IconButton(
                                onPressed: () {
                                  cubit.removefile();
                                },
                                icon: Icon(
                                  IconBroken.Delete,
                                  size: 20,
                                ))),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      OutlinedButton.icon(onPressed: (){
                        cubit.getImagePost();


                      },icon:Icon( IconBroken.Image), label: Text('Add Photo')),
                      Spacer(),
                      OutlinedButton(onPressed: (){}, child: Text('#Tags'))
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
