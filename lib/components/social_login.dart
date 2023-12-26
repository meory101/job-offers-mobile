import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kml/theme/colors.dart';
  
class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            "-Or sign in with -",
            style: TextStyle(
                color: maincolor, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            children: [
              /////facebook
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10)
                      ]),
                  child: SvgPicture.asset(
                    'assets/images/facebook.svg',
                    height: 30,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),

              /////google
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10)
                      ]),
                  child: SvgPicture.asset(
                    'assets/images/google-plus.svg',
                    height: 30,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              /////twitter
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10)
                      ]),
                  child: SvgPicture.asset(
                    'assets/images/twitter.svg',
                    height: 30,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
