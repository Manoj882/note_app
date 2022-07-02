import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/constants/constant.dart';
import 'package:note_app/screens/authentication/login_screen.dart';
import 'package:note_app/services/auth_service.dart';
import 'package:note_app/utils/general_alert_dialog.dart';
import 'package:note_app/widgets/general_text_field.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../home_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: basePadding,
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Register Your Account Here!!!',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text('Email Address'),
              const SizedBox(
                height: 5,
              ),
              GeneralTextField(
                controller: emailController,
                title: 'Email Address',
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validate: (value) =>
                    value!.trim().isEmpty ? 'Enter your email address' : null,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Password'),
              const SizedBox(
                height: 5,
              ),
              GeneralTextField(
                controller: passwordController,
                title: 'Password',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validate: (value) =>
                    value!.trim().isEmpty ? 'Enter your password' : null,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Confirm Password',
              ),
              const SizedBox(
                height: 5,
              ),
              GeneralTextField(
                controller: confirmPasswordController,
                title: 'Confirm Password',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validate: (value) => value!.trim().isEmpty
                    ? 'Enter your confirm password'
                    : null,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    GeneralAlertDialog().customLoadingDialog(context);

                    if (emailController.text == '' ||
                        passwordController.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'All fields are required',
                          ),
                        ),
                      );
                    } else if (passwordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password doesn\'t match'),
                        ),
                      );
                    } else {
                      final result = await AuthService().register(
                        context,
                        emailController.text,
                        passwordController.text,
                      );
                      if (result != null) {
                        debugPrint('Successfully registered');
                        // debugPrint(result.toString());
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => HomeScreen()),
                            (route) => false);
                      }
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Login',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      endIndent: 5,
                    ),
                  ),
                  Text('OR'),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      indent: 5,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SignInButton(
                  Buttons.Google,
                  text: 'Continue with Goolge',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
