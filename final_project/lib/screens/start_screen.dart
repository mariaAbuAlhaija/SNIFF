import 'dart:ui';
import 'package:final_project/controllers/user_controller.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  var show = showing.defualt;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(),
          Center(
            child: Container(
              child: Stack(children: [
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 0,
                    sigmaY: 0,
                  ),
                  child: Container(
                    height: 220.h,
                    width: 360.w,
                  ),
                ),
                Container(
                  height: show == showing.defualt ? 350.h : 600.h,
                  width: 360.w,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                        )
                      ],
                      border: Border.all(
                          color: Colors.white.withOpacity(0.2), width: 1.0),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.2)
                        ],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: content(),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Container background() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backgroung.gif"),
              fit: BoxFit.cover)),
    );
  }

  Widget content() {
    switch (show) {
      case showing.defualt:
        return defualtWidget();
      case showing.signin:
        return signin();
      case showing.signup:
        return signup();
    }
  }

  Padding signin() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                width: 200.w,
                height: 100.h,
                child: ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(Colors.brown, BlendMode.srcIn),
                    child: Image.asset("assets/images/logo.png"))),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
                width: 150,
                child: ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(Colors.brown, BlendMode.srcIn),
                    child: Image.asset("assets/images/sniff.png"))),
            SizedBox(
              height: 50.h,
            ),
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'email',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.email(),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  FormBuilderTextField(
                    name: 'password',
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  SizedBox(
                    width: 350,
                    child: MaterialButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        UserController()
                            .signin(
                                emailController.text, passwordController.text)
                            .then((value) => Navigator.pushReplacementNamed(
                                context, "/home"));
                      },
                      child: const Text("Sign In"),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  InkWell(
                      onTap: () {
                        setState(() {
                          show = showing.signup;
                        });
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 12),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding defualtWidget() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(
              width: 200.w,
              height: 100.h,
              child: ColorFiltered(
                  colorFilter:
                      const ColorFilter.mode(Colors.brown, BlendMode.srcIn),
                  child: Image.asset("assets/images/logo.png"))),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
              width: 150,
              child: ColorFiltered(
                  colorFilter:
                      const ColorFilter.mode(Colors.brown, BlendMode.srcIn),
                  child: Image.asset("assets/images/sniff.png"))),
          SizedBox(
            height: 50.h,
          ),
          MaterialButton(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              setState(() {
                show = showing.signin;
              });
            },
            child: const Text("Sign In"),
          ),
          SizedBox(height: 5.h),
          InkWell(
              onTap: () {
                setState(() {
                  show = showing.signup;
                });
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(fontSize: 12),
              ))
        ],
      ),
    );
  }

  Padding signup() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  width: 200.w,
                  height: 100.h,
                  child: ColorFiltered(
                      colorFilter:
                          const ColorFilter.mode(Colors.brown, BlendMode.srcIn),
                      child: Image.asset("assets/images/logo.png"))),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                  width: 150,
                  child: ColorFiltered(
                      colorFilter:
                          const ColorFilter.mode(Colors.brown, BlendMode.srcIn),
                      child: Image.asset("assets/images/sniff.png"))),
              SizedBox(
                height: 20.h,
              ),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: FormBuilderTextField(
                            name: 'first_name',
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.required(),
                            controller: firstNameController,
                            decoration: const InputDecoration(
                              hintText: "First Name",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: FormBuilderTextField(
                            name: 'last_name',
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.required(),
                            controller: lastNameController,
                            decoration: const InputDecoration(
                              hintText: "Last Name",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    FormBuilderTextField(
                      name: 'email',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.email(),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    FormBuilderTextField(
                      name: 'password',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.compose([
                        (value) {
                          if (!value!.contains(RegExp("(?=.*?[0-9])"))) {
                            return "Include one digit at least";
                          }
                          if (!value.contains(RegExp("(?=.*?[A-Za-z])"))) {
                            return "Include one letter at least";
                          }
                          if (!value.contains(RegExp(".{8,}"))) {
                            return "Include more than 8 characters";
                          }
                        }
                      ]),
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 350,
                      child: MaterialButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            User _user = User(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                email: emailController.text,
                                password: passwordController.text);

                            UserController().create(_user).then((value) {
                              Navigator.pushReplacementNamed(context, "/home");
                            }).catchError((ex, stacktrace) {
                              print("error");
                              print(ex.toString());
                              print(stacktrace);
                            });
                          }
                        },
                        child: const Text("Sign Up"),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    InkWell(
                        onTap: () {
                          setState(() {
                            show = showing.signin;
                          });
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 12),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum showing { signup, signin, defualt }
