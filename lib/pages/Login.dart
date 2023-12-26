import 'package:flutter/material.dart';
import 'package:kml/components/Text_form.dart';
import 'package:kml/components/buttom.dart';
import 'package:kml/components/social_login.dart';
import 'package:kml/theme/colors.dart';
 

class Loginpage extends StatelessWidget {
  Loginpage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/logo.jpg",
                        ))),
              ),
              // SizedBox(
              //   height: 70,
              // ),
              // Container(
              //   width: double.infinity,
              //   height: 200,
              //   alignment: Alignment.center,
              //   child: Image.asset("assets/images/logo.jpg"),
              //   // child: Text(
              //   //   "KML",
              //   //   style: TextStyle(
              //   //       color: GlobalColors.mcolor,
              //   //       fontSize: 35,
              //   //       fontWeight: FontWeight.bold),
              //   // ),
              // ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Login to your Account",
                style: TextStyle(
                    color: maincolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Textform(
                controller: emailController,
                text: 'Email',
                obscure: false,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10,
              ),
              Textform(
                controller: passwordController,
                text: 'Password',
                obscure: true,
                textInputType: TextInputType.visiblePassword,
              ),
              SizedBox(
                height: 50,
              ),
              ButtonGlobal(),
              SizedBox(
                height: 50,
              ),
              SocialLogin(),
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
              "Don\'t have an Account?",
              style: TextStyle(color:maincolor),
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("signup");
                },
                child: Text("Sign up"))
          ],
        ),
      ),
    );
  }
}
