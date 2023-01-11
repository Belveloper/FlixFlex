import 'package:flixflex/controllers/Login/cubit.dart';
import 'package:flixflex/controllers/Login/states.dart';
import 'package:flixflex/views/Components/components.dart';
import 'package:flixflex/views/movie_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (ctx, state) {
          if (state is RegisterErrorState) {
            Fluttertoast.showToast(msg: state.error);
          }
          if (state is LoginErrorState) {
            Fluttertoast.showToast(msg: state.error);
          }
          if (state is RegisterSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }
          if (state is LoginSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }
        },
        builder: (ctx, state) {
          var cubit = LoginCubit.get(ctx);
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
            ),
            body: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cubit.isLogin ? 'Login' : 'Register',
                    style: const TextStyle(
                        fontFamily: 'Poppins-Bold',
                        fontSize: 30,
                        color: Color.fromARGB(255, 118, 132, 255)),
                  ),
                  const Text(
                    'FlixFlex ... your movie app',
                    style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextField(
                      controller: emailController,
                      validate: (p0) {
                        if (p0!.isEmpty || !p0.contains('@')) {
                          return 'invalid email';
                        }
                        return null;
                      },
                      onSave: (p0) {
                        emailController.text = p0!;
                      },
                      icon: Icons.person,
                      hintText: 'Email',
                      hintStyle: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          color: Colors.grey.shade100)),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextField(
                    suffixIcon: IconButton(
                        onPressed: () {
                          cubit.toggleObscure();
                        },
                        icon: cubit.isObscure
                            ? const Icon(
                                Icons.visibility_rounded,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.visibility_off_rounded,
                                color: Colors.white,
                              )),
                    isObscure: cubit.isObscure,
                    controller: passwordController,
                    validate: (p0) {
                      if (p0!.isEmpty || p0.length < 6) {
                        return 'password must not be empty or less than 6 chars';
                      }
                      return null;
                    },
                    onSave: (p0) {
                      passwordController.text = p0!;
                    },
                    icon: Icons.password,
                    hintText: 'Password',
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        color: Colors.grey.shade100),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (cubit.isLogin) {
                            cubit.userLogin(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                          } else {
                            cubit.userRegister(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color.fromARGB(255, 118, 132, 255),
                        ),
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: state is LoginLoadState ||
                                  state is RegisterLoadState
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  cubit.isLogin ? 'Login' : 'Register',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      color: Colors.grey.shade100,
                                      fontSize: 20),
                                ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          cubit.toggleLoginRegister();
                        },
                        child: Text(
                          cubit.isLogin ? 'Register' : 'Login',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              color: Colors.grey.shade100,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
