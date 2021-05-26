import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociaapp/layout/socialApp/cubit/socialCubit.dart';
import 'package:sociaapp/layout/socialApp/cubit/socialState.dart';
import 'package:sociaapp/models/registermodel.dart';
import 'package:sociaapp/modules/chat_details/details.dart';
import 'package:sociaapp/shared/components/component.dart';

class ChatScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.users.length>0,
            builder:(context)=> ListView.separated(itemBuilder: (context,index)=>buildChat(context,cubit.users[index]),
                separatorBuilder:(context,index)=>Container(width: double.infinity,height: 1.0,color: Colors.grey[300],),
                itemCount:SocialCubit.get(context).users.length),
            fallback:(context)=>Center(child: CircularProgressIndicator()),
          );

        });
  }
  Widget buildChat(context, RegisterModel user,)
  {
    return  InkWell(
      onTap: (){
        navigateto(context, ChatDetails(model: user,));
      },
      child: Padding(
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
                  '${user.image}',
                ),
              ),
            ),
            SizedBox(width: 5.0,),
            Text(
              '${user.userName}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
