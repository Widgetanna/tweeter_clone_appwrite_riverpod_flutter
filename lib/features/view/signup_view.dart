import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tweeter_clone/commun/button.dart';
import 'package:flutter_tweeter_clone/constantes/ui_const.dart';
import 'package:flutter_tweeter_clone/features/view/login_view.dart';
import 'package:flutter_tweeter_clone/features/widgets/auth_field.dart';
import 'package:flutter_tweeter_clone/theme/theme.dart';

class SignupView extends StatefulWidget {
   static route() => MaterialPageRoute(
        builder: (context) => const SignupView(),
      );

  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final hintStyle = const TextStyle(fontSize: 18);

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
               const SizedBox(
                height: 100,
              ),
              const Text(
                "Sign Up",
                style: TextStyle(
                  color: Pallete.greyColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              //textfield 1
              AuthField(
                controller: emailController,
                hintText: "Email",
                hintStyle: hintStyle,
                padding: const EdgeInsets.only(left: 10.0),
              ),
              const SizedBox(
                height: 25,
              ),
              //textfield 2
              AuthField(
                controller: passwordController,
                hintText: "Password",
                hintStyle: hintStyle,
                padding: const EdgeInsets.only(left: 10.0),
              ),
              const SizedBox(
                height: 50,
              ),

              Align(
                alignment: Alignment.topRight,
                child: ButtonWidget(
                  onTap: () {},
                  label: "Done",
                  backgroundColor: Pallete.whiteColor,
                  textColor: Pallete.backgroundColor,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              //textspan
              RichText(
                text: TextSpan(
                  text: "Don't have an account?",
                  children: [
                    TextSpan(
                      text: "   Sign up",
                      style: const TextStyle(
                        color: Pallete.blueColor,
                        fontSize: 16,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            LogginView.route(),
                          );
                        },
                    ),
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
