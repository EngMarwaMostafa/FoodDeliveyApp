import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/base/custom_loader.dart';
import 'package:fooddeliveryapp/base/show_custom_snackbar.dart';
import 'package:fooddeliveryapp/controllers/auth_controller.dart';
import 'package:fooddeliveryapp/pages/auth/sign_up_page.dart';
import 'package:fooddeliveryapp/routes/route_helper.dart';
import 'package:fooddeliveryapp/utils/colors.dart';
import 'package:fooddeliveryapp/utils/dimensions.dart';
import 'package:fooddeliveryapp/widgets/app_text_field.dart';
import 'package:fooddeliveryapp/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var emailController = TextEditingController();

    void _login() {
      var authController = Get.find<AuthController>();

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackbar('Type in your email address',
            title: 'Email Address');
      } else if (GetUtils.isEmail(email)) {
        showCustomSnackbar('Type in a valid email address',
            title: 'Valid Email Address');
      } else if (password.isEmpty) {
        showCustomSnackbar('Type in your password', title: 'Password');
      } else if (password.length < 6) {
        showCustomSnackbar('password can not be less than six characters',
            title: 'Password');
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getCartPage());
          } else {
            showCustomSnackbar(status.message);
          }
        });
      }
    }

    return Scaffold(
      //  backgroundColor: Colors.white,
        body:
    //    GetBuilder<AuthController>(builder: (_authController) {
     //    return
           SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.screenHeight * 0.05,
                  ),
                  //App logo
                  Container(
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        backgroundImage: AssetImage('assets/images/s1.jpg'),
                      ),
                    ),
                  ),
                  //welcome
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20),
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello',
                          style: TextStyle(
                            fontSize:
                            Dimensions.font20 * 3 + Dimensions.font20 / 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Sign into your Account',
                          style: TextStyle(
                              fontSize:
                              Dimensions.font20,
                              color: Colors.grey[500]
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                      textController: passwordController,
                      hintText: 'Email',
                      icon: Icons.email),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  AppTextField(
                    textController: emailController,
                    hintText: 'Password',
                    icon: Icons.password_sharp,
                    isObscure: true,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: Dimensions.width15 * 2),
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        RichText(
                          text: TextSpan(
                            text: 'Sign into your account',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight * 0.05,
                  ),
                  //sign in
                  GestureDetector(
                    onTap: () {
                      _login();
                    },
                    child: Container(
                      width: Dimensions.screenWidth / 2,
                      height: Dimensions.screenHeight / 13,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Dimensions.radius30),
                        color: AppColors.mainColor,
                      ),
                      child: Center(
                        child: BigText(
                          text: 'Signin',
                          size: Dimensions.font20 + Dimensions.font20 / 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight * 0.05,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(() => SignUpPage()),
                            text: 'Create',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
           )
    );
  }
}