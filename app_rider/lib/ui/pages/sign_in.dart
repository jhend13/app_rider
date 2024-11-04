import 'package:app_rider/ui/pages/registration.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app_rider/services/auth.dart';
import 'package:app_rider/services/rest_api.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:app_rider/models/user.dart';
import 'package:provider/provider.dart';

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

  bool requestWaiting = false;

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                            labelStyle: theme.textTheme.labelMedium,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.colorScheme.surface,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            )),
                        controller: _email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          // if (!RegExp(r'^[a-zA-Z0-9._%+-]+@us\.af\.mil$')
                          //     .hasMatch(value)) {
                          //   return 'Please enter a valid email';
                          // }
                          return null;
                        },
                        //style: TextStyle(color: theme.colorScheme.onPrimary),
                      ),
                      SizedBox(width: 0, height: 12),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        autofillHints: [AutofillHints.password],
                        decoration: InputDecoration(
                            filled: true,
                            label: Text('Password'),
                            labelStyle: theme.textTheme.labelMedium,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.colorScheme.surface,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            )),
                        //style: TextStyle(color: theme.colorScheme.onPrimary),
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
                              setState(() {
                                requestWaiting = true;
                              });

                              // get user instance
                              // MUST GET OBJ REFERENCE BEFORE AuthService call!
                              User user = context.read<User>();

                              AuthResult result =
                                  await AuthService.signInWithEmailAndPassword(
                                      user, _email.text, _password.text);

                              if (result.isSuccess) {
                                //request our rest api to register user
                                // with newly created firebase UID
                                await RestApiService.syncUser(user)
                                    .then((User user) {
                                  // success!;
                                }).catchError((error) {
                                  //should probably log out the instance?
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      result.message,
                                      style: TextStyle(
                                          color: theme.colorScheme.onError),
                                    ),
                                    backgroundColor: theme.colorScheme.error,
                                  ),
                                );

                                // setState must be within this code block
                                // if sign in is successful, setState will try to call but the widget
                                // after auth_guard router has already switched the active page.
                                setState(() {
                                  requestWaiting = false;
                                });
                              }
                            }
                          },
                          child: requestWaiting
                              ? SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    color: theme.colorScheme.onSecondary,
                                    strokeWidth: 2,
                                  ))
                              : Text('Sign In'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary),
                        ),
                      ),
                      SizedBox(width: 0, height: 20),
                      RichText(
                        text: TextSpan(
                            style: theme.textTheme.bodyLarge,
                            children: [
                              TextSpan(text: 'Don\'t have an account? '),
                              TextSpan(
                                text: 'Create account',
                                recognizer: _tapRecognizer
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegistrationPage()),
                                    );
                                  },
                                style: TextStyle(
                                    color: theme.colorScheme.tertiary,
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
