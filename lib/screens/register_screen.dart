import 'package:flutter/material.dart';
import 'package:note_app/constants/constant.dart';
import 'package:note_app/screens/login_screen.dart';
import 'package:note_app/widgets/general_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
