import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociaapp/layout/socialApp/socialApp.dart';
import 'package:sociaapp/modules/register/cubit/registerstate.dart';
import 'package:sociaapp/shared/components/component.dart';
import 'package:sociaapp/shared/network/local/shared_preferences.dart';

import 'cubit/registercubit.dart';

class RegisterPage extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSucessState) {
            CacheHelper.putdata(key: 'uid', value: state.uid);
            navigateRoute(context, SocialHome());
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white60,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'REGISTER now to communication with friends',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          defaultTextField(
                            controller: nameController,
                            label: 'UserName',
                            prefix: Icons.person,
                            textInputType: TextInputType.text,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'please enter name';
                              } else
                                return null;
                            },
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          defaultTextField(
                            controller: emailController,
                            label: 'Email',
                            prefix: Icons.email,
                            textInputType: TextInputType.emailAddress,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'please enter email';
                              } else
                                return null;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultTextField(
                            controller: passwordController,
                            label: 'password',
                            prefix: Icons.lock,
                            suffix: cubit.suffix,
                            presssufix: () => cubit.changePassword(),
                            obscure: cubit.ispassword,
                            textInputType: TextInputType.visiblePassword,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'please enter password';
                              } else
                                return null;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultTextField(
                            controller: phoneController,
                            label: 'phone',
                            prefix: Icons.phone,
                            textInputType: TextInputType.phone,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'please enter phone';
                              } else
                                return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => defaultbutton(
                              press: () {
                                if (formKey.currentState.validate()) {
                                  cubit.register(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                }
                              },
                              text: 'register',
                            ),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
