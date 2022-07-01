import 'package:flutter/material.dart';
import 'package:note_app/constants/constant.dart';
import 'package:note_app/screens/authentication/register_screen.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/services/auth_service.dart';
import 'package:note_app/utils/general_alert_dialog.dart';
import 'package:note_app/widgets/general_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                  'Login Here',
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
                textInputAction: TextInputAction.done,
                validate: (value) =>
                    value!.trim().isEmpty ? 'Enter your password' : null,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    GeneralAlertDialog().customLoadingDialog(context);
                    if (emailController.text == '' ||
                        passwordController.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'All fields are reuired!!!',
                          ),
                        ),
                      );
                    } else {
                      final result = await AuthService().login(context,
                          emailController.text, passwordController.text);
                      if (result != null) {
                        debugPrint('Successfully logged in');
                        // debugPrint(result.toString());
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                      }
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Login',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Register',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
