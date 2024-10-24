import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app_rider/services/auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final TapGestureRecognizer _tapRecognizer = TapGestureRecognizer();

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: EdgeInsets.all(32),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome Back',
                          style: Theme.of(context).textTheme.displaySmall),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                        child: Text('Sign in to start using AADD services.'),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        //autofocus: true,
                        autofillHints: [AutofillHints.email],
                        decoration: InputDecoration(
                            filled: true,
                            label: Text('Email'),
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.surface,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            )),
                        controller: _email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@us\.af\.mil$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        //style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      SizedBox(width: 0, height: 12),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        autofillHints: [AutofillHints.password],
                        decoration: InputDecoration(
                            filled: true,
                            label: Text('Password'),
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.surface,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            )),
                        //style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        controller: _password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(width: 0, height: 20),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              AuthResult result =
                                  await AuthService.signInWithEmailAndPassword(
                                      _email.text, _password.text);
                              if (!result.isSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      result.message,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onError),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.error,
                                  ),
                                );
                              }
                            }
                          },
                          child: Text('Sign In'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                      SizedBox(width: 0, height: 20),
                      RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: [
                              TextSpan(text: 'Don\'t have an account? '),
                              TextSpan(
                                text: 'Create account',
                                recognizer: _tapRecognizer
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(
                                        context, '/sign-up');
                                  },
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                      )
                    ]),
              ),
            )),
      ),
    );
  }
}
