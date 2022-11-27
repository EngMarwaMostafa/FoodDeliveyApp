import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/base/custom_loader.dart';
import 'package:fooddeliveryapp/base/show_custom_snackbar.dart';
import 'package:fooddeliveryapp/controllers/auth_controller.dart';
import 'package:fooddeliveryapp/models/signup_body_model.dart';
import 'package:fooddeliveryapp/routes/route_helper.dart';
import 'package:fooddeliveryapp/utils/colors.dart';
import 'package:fooddeliveryapp/utils/dimensions.dart';
import 'package:fooddeliveryapp/widgets/app_text_field.dart';
import 'package:fooddeliveryapp/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = ['t.png', 'f.png', 'g.png'];

    void _registration() {
      var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackbar('Type in your name', title: 'Name');
      } else if (phone.isEmpty) {
        showCustomSnackbar('Type in your phone number', title: 'Phone Number');
      } else if (email.isEmpty) {
        showCustomSnackbar('Type in your email address',
            title: 'Email Address');
      } else if (GetUtils.isEmail(email)) {
        showCustomSnackbar('Type in a valid email address',
            title: 'Valid Email Address');
      } else if (password.isEmpty) {
        showCustomSnackbar('Type in your password', title: 'Password');
      } else if (password.length < 6) {
        showCustomSnackbar('password can not be less than six characters', title: 'Password');
      } else {
        showCustomSnackbar('All Went Well', title: 'Perfect');
        SignUpBody signUpBody = SignUpBody(
            name: name, email: email, phone: phone, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print('SUCESS REGISTRATION');
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackbar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body:
          //GetBuilder<AuthController>(builder: (authController){
          //   return !authController.isLoading?
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
              height: Dimensions.height20,
            ),
            AppTextField(
                textController: nameController,
                hintText: 'Name',
                icon: Icons.person),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
                textController: phoneController,
                hintText: 'Phone',
                icon: Icons.phone),
            SizedBox(
              height: Dimensions.height20,
            ),
            GestureDetector(
              onTap: () {
                _registration();
              },
              child: Container(
                width: Dimensions.screenWidth / 2,
                height: Dimensions.screenHeight / 13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor,
                ),
                child: Center(
                  child: BigText(
                    text: 'Sign Up',
                    size: Dimensions.font20 + Dimensions.font20 / 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                text: 'Already have an account?',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.screenHeight * .05,
            ),
            RichText(
              text: TextSpan(
                text: 'Sign up using one of the following methods',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font16,
                ),
              ),
            ),
            Wrap(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage:
                        AssetImage('assets/images' + signUpImages[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
