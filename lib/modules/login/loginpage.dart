import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociaapp/layout/socialApp/socialApp.dart';
import 'package:sociaapp/modules/login/cubit/logincubit.dart';
import 'package:sociaapp/modules/register/registerpage.dart';
import 'package:sociaapp/shared/components/component.dart';
import 'package:sociaapp/shared/network/local/shared_preferences.dart';

import 'cubit/loginstate.dart';

class LoginPage extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            defaultMessage(message: state.error);
          } else if (state is LoginSucessState) {
            CacheHelper.putdata(key: 'uid', value: state.uid);
            navigateRoute(context, SocialHome());
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'LOGIN now to communication with friends',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(fontSize: 16, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          defaultTextField(
                            controller: emailController,
                            label: 'Email',
                            prefix: Icons.email,
                            textInputType: TextInputType.text,
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
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => defaultbutton(
                                text: 'LOGIN',
                                press: () {
                                  if (formKey.currentState.validate()) {
                                    cubit.signIn(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                }),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Need an account?',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        fontSize: 20.0,
                                        color: Colors.grey[600]),
                              ),
                              defaultTextButton(
                                  text: 'REGISTER',
                                  function: () {
                                    navigateto(context, RegisterPage());
                                  }),
                            ],
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
