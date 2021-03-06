import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/components/default_button.dart';
import '../../shared/components/form_field.dart';
import '../../shared/components/toast.dart';
import '../login/cubit/login_cubit.dart';
import '../login/login_screen.dart';
import 'package:flutter/material.dart';
import '../main_screens/home_screen.dart';
import 'cubit/singed_up_cubit.dart';
import 'cubit/singed_up_state.dart';

class SingUpScreen extends StatefulWidget {
  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var cityController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool isHide = true;
  bool isHideConfirm = true;

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return BlocProvider(
      create: (BuildContext context) => SingedUpCubit(),
      child: BlocConsumer<SingedUpCubit, SingedUpState>(
          listener: (context, state) {
        if (state is SingedUpSuccessState) {
          if (state.singedUpModel.status == 'success') {
            CacheHelper.saveData(key: 'token', value: state.singedUpModel.token).then((value) {
              navigateAndFinish(context, HomeScreen());
            });
             showToast(
              text: state.singedUpModel.message!,
              state: ToastStates.SUCCESS,
            );
            navigateAndFinish(context, HomeScreen());
          } else {
            print('${state.singedUpModel.message}');
            showToast(
              text: state.singedUpModel.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                backGround(),
                SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                              )),
                          SizedBox(height: 5),
                          defaultField(
                              controller: emailController,
                              typeOfInput: TextInputType.emailAddress,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter correct email';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Name',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                              )),
                          SizedBox(height: 5),
                          defaultField(
                              controller: nameController,
                              typeOfInput: TextInputType.name,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter correct name';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Phone Number',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                              )),
                          SizedBox(height: 5),
                          defaultField(
                              controller: phoneController,
                              typeOfInput: TextInputType.phone,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter correct phone number';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          Text('City Town',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                              )),
                          SizedBox(height: 5),
                          defaultField(
                              controller: cityController,
                              typeOfInput: TextInputType.name,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter correct city';
                                }
                                return null;
                              }),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                        label: Text('password'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: confirmPasswordController,
                                    decoration: InputDecoration(
                                        label: Text('confirm password'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          // Spacer(),
                          Center(
                            child: ConditionalBuilder(
                              condition: state is! SingedUpLodingState,
                              builder: (context) => defaultButton(
                                  width: 150,
                                  color: Colors.black,
                                  colorText: Colors.white,
                                  text: 'Register',
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      SingedUpCubit.get(context).getUserOne(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        confirmPassword:
                                            confirmPasswordController.text,
                                        phone: phoneController.text,
                                        name: nameController.text,
                                      );
                                    } //navigateTo(context, HomeScreen());
                                  }),
                              fallback: (context) => Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.red)),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              Center(
                                  child: Text(
                                'or',
                                style: TextStyle(fontSize: 20),
                              )),
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account ?',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 70,
                                height: 30,
                                child: TextButton(
                                    onPressed: () {
                                      navigateTo(context, LoginScreen());
                                    },
                                    child: Text(
                                      'LOG IN',
                                      style: TextStyle(color: Colors.black),
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

Widget backGround() => Container(
  width: double.infinity,
  height: 340,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/create.png'),
          fit: BoxFit.fill,
        ),
      ),
    );

Widget backGroundu() => Container(
      decoration: BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage('assets/3.png'),
        //   fit: BoxFit.cover,
        // ),
        color: Colors.white,
      ),
    );
