import 'package:flutter/material.dart';
import 'package:kml/components/text_form.dart';
import 'package:kml/components/rectangular_button.dart';
import 'package:kml/components/social_login.dart';
import 'package:kml/pages/home.dart';
import 'package:kml/pages/signup.dart';
import 'package:kml/theme/fonts.dart';

class Loginpage extends StatelessWidget {
  Loginpage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> fkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
              key:fkey ,
              child: Column(
                      children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/logo.jpg",
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Login to your Account",
                      style: submain,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Textform(
                       val: (p0) {
                        if (p0!.isNotEmpty) {
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(p0)) {
                            return 'Email format is wrong';
                          }
                          if (p0 != 'kml@gmail.com') {
                            return 'email is not found';
                          }
                        } else
                          return 'Email can\'t be empty';
                        return null;
                      },
                      controller: emailController,
                      text: 'Email',
                      obscure: false,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Textform(
                       val: (p0) {
                        if (p0!.isNotEmpty) {
                          if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$')
                                  .hasMatch(p0) ||
                              p0.length < 6) {
                            return 'password format is wrong';
                          }
                          // setState(() {
                          // password = p0;
                          // });
                        } else
                          return 'password can\'t be empty';
                        return null;
                      },
                      controller: passwordController,
                      text: 'Password',
                      obscure: true,
                      textInputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RecButton(
                      fun: () {
                        if(fkey.currentState!.validate()){
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return Home();
                              },
                            ),
                          );
                        }
                       
                      },
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      label: Text(
                        'SignIn',
                        style: subwfont,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SocialLogin(),
                  ],
                ),
              ),
                      ],
                    ),
            )),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 50,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an Account? ",
              style: submain,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return Signup();
                    },
                  ),
                );
              },
              child: Text(
                "Sign up",
                style: subbfont,
              ),
            )
          ],
        ),
      ),
    );
  }
}
