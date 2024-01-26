import 'dart:convert';

// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kml/components/rectangular_button.dart';
import 'package:kml/components/text_form.dart';
import 'package:kml/db/links.dart';
import 'package:kml/pages/Login.dart';
import 'package:kml/pages/companyinfo.dart';
import 'package:kml/pages/home.dart';
import 'package:kml/pages/userinfo.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

int selectedtype = 0;

class _SignUpState extends State<SignUp> {
  final TextEditingController userController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> fkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    singUp() async {
      print("ssssssssssssssssssss");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (fkey.currentState!.validate()) {
        try {
          var url = selectedtype == 0 ? Uri.parse(usignup) : Uri.parse(csignup);
          Map body = {
            'name': userController.text,
            'email': emailController.text,
            'password': passwordController.text
          };
          http.Response response = await http.post(url, body: body);
          body = jsonDecode(response.body);
          print(body);
          if (body['status'] == 'success') {
            selectedtype == 0
                ? prefs.setString('user_id', body['userid'])
                : prefs.setString('com_id', body['comid']);
            prefs.setString('token', body['token']);
            print(prefs.getString('com_id'));
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return selectedtype == 0 ? userinfo() : companyinfo();
                },
              ),
            );
          } else {
            return AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'Error',
              desc: '${body['message']}',
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            )..show();
          }
        } catch (e) {
          print(e);
        }
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: fkey,
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
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Create New Account", style: submain),
                    const SizedBox(
                      height: 20,
                    ),
                    Textform(
                      val: (p0) {
                        if (p0!.isNotEmpty) {
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$')
                              .hasMatch(p0)) {
                            return 'name format is wrong';
                          }
                        } else {
                          return 'name can\'t be empty';
                        }
                        return null;
                      },
                      controller: userController,
                      text: 'Username',
                      obscure: false,
                      textInputType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Textform(
                      val: (p0) {
                        if (p0!.isNotEmpty) {
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(p0)) {
                            return 'Email format is wrong';
                          }
                        } else {
                          return 'Email can\'t be empty';
                        }
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
                        } else {
                          return 'password can\'t be empty';
                        }
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Choose your account type",
                            style: submain,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedtype = 0;
                                  });
                                },
                                child: RecButton(
                                  color: selectedtype == 0
                                      ? maincolor
                                      : Colors.white,
                                  label: Text(
                                    'User',
                                    style:
                                        selectedtype == 0 ? subwfont : subpfont,
                                  ),
                                  width: 100,
                                  height: 40,
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedtype = 1;
                                  });
                                },
                                child: RecButton(
                                  label: Text(
                                    'Company',
                                    style:
                                        selectedtype == 1 ? subwfont : subpfont,
                                  ),
                                  color: selectedtype == 1
                                      ? maincolor
                                      : Colors.white,
                                  width: 100,
                                  height: 40,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RecButton(
                            color: maincolor,
                            fun: singUp,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            label: Text(
                              'SignUp',
                              style: subwfont,
                            ),
                          ),
                        ],
                      ),
                    ),
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
              "Do you  have an Account? ",
              style: submain,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return Loginpage();
                    },
                  ),
                );
              },
              child: Text(
                "Sign In",
                style: subbfont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
