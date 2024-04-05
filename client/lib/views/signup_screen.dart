import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_journey_app/utils/themes/app_colors.dart';

import '../constants/font_manager.dart';
import '../constants/value_manager.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_form_field.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static const String routeName = '/signupScreen';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Form(
                key: controller.signupFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/icons/logos_png/logo.png',
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const Txt(
                        text: "Create your Account",
                        textAlign: TextAlign.center,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.titleFontSize,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const Txt(
                        text: "Sign up now to get started with an account",
                        textAlign: TextAlign.center,
                        color: AppColors.secondaryLight,
                        fontWeight: FontWeight.normal,
                        fontSize: FontSize.subTitleFontSize,
                      ),
                    ),
                    const SizedBox(
                      height: SizeManager.sizeXL,
                    ),
                    CustomTextFormField(
                      controller: controller.nameController,
                      labelText: "Full Name",
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.person,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name cannot be empty.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: SizeManager.sizeSemiM,
                    ),
                    CustomTextFormField(
                      controller: controller.phoneController,
                      labelText: "Contact Number",
                      autofocus: false,
                      hintText: "033X-XXXXXXX",
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone cannot be empty.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: SizeManager.sizeSemiM,
                    ),
                    CustomTextFormField(
                      controller: controller.emailController,
                      labelText: "Email",
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email cannot be empty.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: SizeManager.sizeSemiM,
                    ),
                    CustomTextFormField(
                      controller: controller.cnicController,
                      labelText: "CNIC",
                      autofocus: false,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.home,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "CNIC cannot be empty.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: SizeManager.sizeSemiM,
                    ),
                    Obx(
                      () => CustomTextFormField(
                        controller: controller.passwordController,
                        autofocus: false,
                        labelText: "Password",
                        obscureText: controller.isObscure.value,
                        prefixIconData: Icons.vpn_key_rounded,
                        suffixIconData: controller.isObscure.value
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        onSuffixTap: controller.toggleVisibility,
                        textInputAction: TextInputAction.done,
                        onFieldSubmit: (_) async {
                          await controller.signUpUser(
                            email: controller.emailController.text,
                            name: controller.nameController.text,
                            password: controller.passwordController.text,
                            phone: controller.phoneController.text,
                            cnic: controller.cnicController.text,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty.";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: SizeManager.sizeXL,
                    ),
                    Obx(
                      () => CustomButton(
                        color: AppColors.primary,
                        hasInfiniteWidth: true,
                        loadingWidget: controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor: AppColors.background,
                                ),
                              )
                            : null,
                        onPressed: () async {
                          await controller.signUpUser(
                            email: controller.emailController.text,
                            name: controller.nameController.text,
                            password: controller.passwordController.text,
                            phone: controller.phoneController.text,
                            cnic: controller.cnicController.text,
                          );
                        },
                        text: "Register",
                        textColor: AppColors.background,
                        buttonType: ButtonType.loading,
                      ),
                    ),
                    const SizedBox(
                      height: SizeManager.sizeL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Txt(
                          text: "Already have an account? ",
                          fontSize: FontSize.subTitleFontSize,
                          color: AppColors.secondaryLight,
                        ),
                        InkWell(
                          onTap: () {
                            controller.clearfields();
                            Get.offAll(const LoginScreen());
                          },
                          child: const Txt(
                            text: "Login",
                            fontSize: FontSize.subTitleFontSize,
                            color: AppColors.secondary,
                            fontWeight: FontWeightManager.semibold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
