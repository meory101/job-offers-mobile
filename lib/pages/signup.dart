import 'package:flutter/material.dart';
import 'package:kml/components/Text_form.dart';
import 'package:kml/components/buttom.dart';
import 'package:kml/components/social_login.dart';
import 'package:kml/theme/colors.dart';
 

class Signup extends StatelessWidget {
  Signup({super.key});
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: 20,
              // ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          "assets/images/logo.jpg",
                        ))),
                // child: Center(
                //   child: Image.asset(
                //     "assets/images/logo.jpg",
                //     height: 200,
                //     alignment: Alignment.center,
                //     fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Create New Account",
                style: TextStyle(
                    color:maincolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              Textform(
                controller: userController,
                text: 'Username',
                obscure: false,
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: 10,
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
                height: 20,
              ),
              Column(
                children: [
                  Text("Choose your account type"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Employe"),
                      Radio(
                          value: "emp",
                          groupValue: Employee,
                          onChanged: (val) {
                            // ignore: unused_local_variable
                            var emp = val;
                          }),
                      Text("Company"),
                      Radio(
                          value: "emp",
                          groupValue: Employee,
                          onChanged: (val) {
                            // ignore: unused_local_variable
                            var emp = val;
                          }),
                    ],
                  ),
                ],
              ),
              ButtonGlobal(),
              SizedBox(
                height: 30,
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
              "Do you  have an Account?",
              style: TextStyle(color:maincolor),
            ),
            InkWell(child: Text("Sign In"))
          ],
        ),
      ),
    );
  }
}

class Employee {
  late String emp;
}
