import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth/login_controller.dart';
import '../core/app_string.dart';
import '../widgets/custom_textformfiled.dart';
import '../widgets/progressbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (_) {
        return Scaffold(
          body: ProgressBar(
            loading: _.isLoading,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.pink,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 40,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        AppStrings.shopName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                       AppStrings.yourFavoriteOnlineStore,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 20),


                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Form(
                          key: _.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                AppStrings.usernameTextFieldName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              CustomTextFormField(
                                controller: _.controllerName,
                                keyboardType: TextInputType.text,
                                validator: _.validateUserName,
                                onChanged: _.onChangeUserName,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                              ),
                              const SizedBox(height: 20),


                              const Text(
                                AppStrings.passwordTextFieldId,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GetBuilder<LoginController>(
                                id: AppStrings.labelPassword,
                                builder: (_) {
                                  return CustomTextFormField(
                                    controller: _.controllerPass,
                                    keyboardType: TextInputType.text,
                                    validator: _.validatePass,
                                    onChanged: _.onChangePass,
                                    obscureText: !_.isVisibilityPass,
                                    suffixIcon: IconButton(
                                      icon: !_.isVisibilityPass ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                                      onPressed: _.changePasswordVisibility,
                                    ),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                  );
                                },
                              ),
                              const SizedBox(height: 25),
                              GetBuilder<LoginController>(
                                id: AppStrings.btnLoginId,
                                builder: (_) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: _.isCompleteForm ? [Colors.orange, Colors.pink] : [Colors.grey, Colors.grey.shade400],
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        onPressed: _.isCompleteForm ? () => _.onLogin() : null,
                                        child: const Text(
                                          AppStrings.signIn,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 25),


                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.demoCredentials,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(AppStrings.demoUserName),
                                    Text(AppStrings.demoPassword),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
