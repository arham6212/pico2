import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pico2/controller/auth_controller.dart';
import 'package:pico2/theme/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _logoPositionAnimation;
  late Animation<double> _fabSizeAnimation;
  late Animation<double> _fabOpacityAnimation;
  late Animation<double> _fabRotationAnimation;

  bool hidePassword = true;
  bool showShowButton = false;
  final _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _logoPositionAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _fabSizeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _fabOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _fabRotationAnimation = Tween<double>(begin: 0, end: 360).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SlideTransition(
                position: _logoPositionAnimation,
                child: Text(
                  'Piccolo',
                  style: Get.theme.textTheme.headline2
                      ?.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 25),
              SlideTransition(
                position: _logoPositionAnimation,
                child: buildLoginTextFields(
                  textEditingController: emailController,
                  hintText: 'Enter Email',
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: const Offstage(),
                  validator: (String? email) {
                    if (email!.isEmpty) {
                      return 'Please provide an email';
                    } else if (!GetUtils.isEmail(email)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 25),
              SlideTransition(
                position: _logoPositionAnimation,
                child: buildLoginTextFields(
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
                          child: Icon(
                            Icons.visibility,
                            color: kBlueColor,
                          ),
                        )
                      : const Offstage(),
                  validator: (String? password) {
                    if (password!.isEmpty) {
                      return 'Please enter a password';
                    } else if (password.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _fabSizeAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _fabOpacityAnimation.value,
            child: Transform.scale(
              scale: _fabSizeAnimation.value,
              child: Transform.rotate(
                angle: _fabRotationAnimation.value * (3.1415927 / 180),
                child: Container(
                  width: 120,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      colors: [Color(0xFF2F80ED), Color(0xFF56CCF2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF2F80ED).withOpacity(0.3),
                        offset: Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await authController.login(
                            loginDetails: {
                              'email': emailController.text.trim(),
                              'password': passwordController.text.trim(),
                            },
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoginTextFields({
    bool? obscureText,
    required String hintText,
    required TextEditingController textEditingController,
    required Widget suffixIcon,
    required String? Function(String?)? validator,
    required TextInputType keyboardType,
  }) {
    return SizedBox(
      width: Get.mediaQuery.size.width * 0.7,
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText ?? false,
        obscuringCharacter: '*',
        onChanged: (String val) {
          setState(() {
            showShowButton = val.isNotEmpty;
          });
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          filled: true,
          fillColor: Colors.black.withOpacity(0.3),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
