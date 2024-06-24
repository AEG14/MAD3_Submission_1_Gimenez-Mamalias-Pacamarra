import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../app_styles.dart';
import '../../controllers/auth_controller.dart';
import '../../dialogs/waiting_dialog.dart';
import '../../widgets/customized_input_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String route = '/LoginScreen';
  static const String path = "/LoginScreen";
  static const String name = "User Login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController usernameController, passwordController;
  late FocusNode usernameFn, passwordFn;

  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    usernameFn = FocusNode();
    passwordFn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    usernameFn.dispose();
    passwordFn.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 242, 239),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image.asset(
                      'assets/images/CreateAccount-BG.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Welcome back,',
                        style: tPoppinsBold.copyWith(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Please sign in to continue',
                        style: tPoppinsRegular.copyWith(
                          fontSize: 17,
                          color: const Color.fromARGB(255, 62, 60, 60),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildLoginForm(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: tPoppinsRegular,
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Sign up',
                          style: tPoppinsBold.copyWith(
                            color: const Color(0xff242F9B),
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildSocialMediaIcons('assets/images/google.png', () {
                        // print('Google image tapped');
                      }),
                      const SizedBox(width: 10),
                      buildSocialMediaIcons('assets/images/fb.png', () {
                        // print('Facebook image tapped');
                      }),
                      const SizedBox(width: 10),
                      buildSocialMediaIcons('assets/images/apple-logo.png', () {
                        // print('Apple image tapped');
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      WaitingDialog.show(context,
          future: AuthController.I.login(
              usernameController.text.trim(), passwordController.text.trim()));
    }
  }

  //builder function for social media icons
  Widget buildSocialMediaIcons(String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromARGB(255, 239, 231, 231),
            ),
            height: 60,
            width: 60,
            child: Image.asset(imagePath),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          CustomizedInputField(
            controller: usernameController,
            labelText: 'Username',
            hintText: 'Enter your username',
            prefixIcon: Icons.person_outline,
            focusNode: usernameFn,
            onEditingComplete: () {
              passwordFn.requestFocus();
            },
            validators: [
              MultiValidator(
                [
                  RequiredValidator(errorText: 'Please fill out the username'),
                  MaxLengthValidator(32,
                      errorText: "Username cannot exceed 32 characters"),
                  PatternValidator(r'^[a-zA-Z0-9 ]+$',
                      errorText: 'Username cannot contain special characters'),
                ],
              ).call,
            ],
          ),
          const SizedBox(height: 10),
          CustomizedInputField(
            controller: passwordController,
            labelText: 'Password',
            hintText: 'Enter your password',
            obscureText: true,
            prefixIcon: Icons.lock_outline,
            suffixIcon: Iconsax.eye_slash,
            focusNode: passwordFn,
            onEditingComplete: () {
              onSubmit();
            },
            validators: [
              MultiValidator(
                [
                  RequiredValidator(errorText: "Password is required"),
                  MinLengthValidator(12,
                      errorText:
                          "Password must be at least 12 characters long"),
                  MaxLengthValidator(128,
                      errorText: "Password cannot exceed 72 characters"),
                  PatternValidator(
                      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?\-=[\]{};':,.<>]).*$",
                      errorText:
                          'Password must contain\n \u2022 At least one symbol (e.g., !, @, #)\n \u2022 One uppercase letter (A-Z)\n \u2022 One lowercase letter (a-z)\n \u2022 One number (0-9)'),
                ],
              ).call,
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  // print('forgot password');
                },
                child: Text(
                  'Forgot password?',
                  style: tPoppinsMedium.copyWith(
                    fontSize: 13,
                    color: const Color.fromARGB(255, 96, 94, 94),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              onSubmit();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff242F9B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              height: 50,
              child: _isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Signing in...',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Sign in',
                      style: tPoppinsBold.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
