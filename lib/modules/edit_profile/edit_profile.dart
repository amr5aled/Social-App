import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociaapp/layout/socialApp/cubit/socialCubit.dart';
import 'package:sociaapp/layout/socialApp/cubit/socialState.dart';
import 'package:sociaapp/shared/components/component.dart';
import 'package:sociaapp/shared/styles/icon_broken.dart';

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          nameController.text = cubit.model.userName;
          bioController.text = cubit.model.bio;
          phoneController.text = cubit.model.phone;

          return Scaffold(
            appBar:
                defaultAppBar(context: context, title: 'EditProfile', actions: [
              defaultTextButton(
                function: () {
                  cubit.updateUser(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                  );
                },
                text: 'Update',
              ),
              SizedBox(
                width: 10,
              ),
            ]),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUpdateLoadingState)
                    LinearProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 175,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
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
                                      image: cubit.coverImage == null
                                          ? NetworkImage(
                                        '${cubit.model.cover}',
                                      )
                                          : FileImage(cubit.coverImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                      radius: 18,
                                      child: IconButton(
                                          onPressed: () {
                                            cubit.getcoverImage();
                                          },
                                          icon: Icon(
                                            IconBroken.Camera,
                                            size: 20,
                                          ))),
                                ),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            radius: 64.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: cubit.profileImage == null
                                      ? NetworkImage(
                                          '${cubit.model.image}',
                                        )
                                      : FileImage(cubit.profileImage),
                                ),
                                CircleAvatar(
                                    radius: 18,
                                    child: IconButton(
                                        onPressed: () {
                                          cubit.getprofileImage();
                                        },
                                        icon: Icon(
                                          IconBroken.Camera,
                                          size: 20,
                                        ))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultTextField(
                      controller: nameController,
                      label: 'UserName',
                      prefix: IconBroken.User,
                      textInputType: TextInputType.name,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'please enter name';
                        } else
                          return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultTextField(
                      controller: bioController,
                      label: 'bio',
                      prefix: IconBroken.Activity,
                      textInputType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'please enter bio';
                        } else
                          return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultTextField(
                      controller: phoneController,
                      label: 'phone',
                      prefix: IconBroken.Call,
                      textInputType: TextInputType.phone,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'please enter phone';
                        } else
                          return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
