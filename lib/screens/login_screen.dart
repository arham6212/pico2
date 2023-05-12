import 'package:pico2/common/common_widgets.dart';
import 'package:pico2/controller/auth_controller.dart';
import 'package:pico2/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;

  bool showShowButton = false;
  final _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  var emailController = TextEditingController(),
      passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Login',
                style: Get.theme.textTheme.headline2
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 25),
              buildLoginTextFields(
                  textEditingController: emailController,
                  hintText: 'Enter  Email',
                  keyBoardType: TextInputType.emailAddress,
                  suffixIcon: const Offstage(),
                  validator: (String? email) {
                    if (email!.isEmpty) {
                      return 'Please provide an email';
                    } else if (!email.isEmail) {
                      return 'Please enter valid email';
                    }
                    return null;
                  }),
              const SizedBox(height: 25),
              buildLoginTextFields(
                obscureText: hidePassword,
                textEditingController: passwordController,
                hintText: 'Enter password',
                suffixIcon: showShowButton
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              hidePassword ? 'Show' : 'Hide',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kBlueColor),
                            ),
                          ],
                        ),
                      )
                    : const Offstage(),
                validator: (String? password) {
                  if (password!.isEmpty) {
                    return 'Please enter password';
                  } else if (password.length < 6) {
                    return 'Password must be greater than 6 digits';
                  }
                  return null;
                },
                keyBoardType: TextInputType.visiblePassword,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await authController.login(loginDetails: {
              'email': emailController.text.trim(),
              'password': passwordController.text.trim()
            });
          }
        },
        child: const Icon(
          Icons.login,
          size: 36,
        ),
      ),
    );
  }

  Widget buildLoginTextFields(
      {bool? obscureText,
      required String hintText,
      required TextEditingController textEditingController,
      required Widget suffixIcon,
      required String? Function(String?)? validator,
      required TextInputType keyBoardType}) {
    return SizedBox(
        width: Get.mediaQuery.size.width * 0.7,
        child: TextFormField(
          controller: textEditingController,
          keyboardType: keyBoardType,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText ?? false,
          obscuringCharacter: '*',
          onChanged: (String val) {
            if (val.isNotEmpty) {
              setState(() {
                showShowButton = true;
              });
            } else {
              setState(() {
                showShowButton = false;
              });
            }
          },
          style: Get.textTheme.bodyText2?.copyWith(color: kThemeOrangeColor),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: kThemeOrangeColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: kThemeOrangeColor)),
          ),
        ));
  }
}
