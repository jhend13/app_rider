import 'package:app_rider/ui/pages/sign_in.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app_rider/services/auth.dart';
import 'package:app_rider/services/api/rest.dart';
import 'package:app_rider/models/user.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

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
                      Text('Create Account',
                          style: theme.textTheme.displaySmall),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                        child: Text('Sign in to start using AADD services.'),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        //autofocus: true,
                        autofillHints: [AutofillHints.name],
                        decoration: InputDecoration(
                            filled: true,
                            label: Text('Name'),
                            labelStyle: theme.textTheme.labelMedium,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.colorScheme.surface,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            )),
                        controller: _name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        //style: TextStyle(color: theme.colorScheme.onPrimary),
                      ),
                      SizedBox(width: 0, height: 12),
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
                      SizedBox(width: 0, height: 12),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        autofillHints: [AutofillHints.password],
                        decoration: InputDecoration(
                            filled: true,
                            label: Text('Confirm Password'),
                            labelStyle: theme.textTheme.labelMedium,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.colorScheme.surface,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            )),
                        //style: TextStyle(color: theme.colorScheme.onPrimary),
                        controller: _confirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (_password.text != _confirmPassword.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(width: 0, height: 12),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  requestWaiting = true;
                                });

                                // get reference to user instance
                                // from provider
                                User user = context.read<User>();

                                // register user with Firebase
                                AuthResult result = await AuthService
                                    .createUserWithEmailAndPassword(
                                        user, _email.text, _password.text);

                                if (result.isSuccess) {
                                  //request our rest api to register user
                                  // with newly created firebase UID
                                  await RestApiService.createAndSyncUser(
                                          user, _name.text)
                                      .then((User user) {
                                    user.name = _name.text;
                                    // success!;
                                  }).catchError((error) {
                                    // failed to create profile with external api server
                                    // delete the created firebase account
                                    AuthService.deleteUser();
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
                            style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary),
                            child: requestWaiting
                                ? SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      color: theme.colorScheme.onSecondary,
                                      strokeWidth: 2,
                                    ))
                                : Text('Create Account')),
                      ),
                      SizedBox(width: 0, height: 20),
                      RichText(
                        text: TextSpan(
                            style: theme.textTheme.bodyLarge,
                            children: [
                              TextSpan(text: 'Already have an account? '),
                              TextSpan(
                                text: 'Sign in',
                                recognizer: _tapRecognizer
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInPage()),
                                    );
                                    //Navigator.pushNamed(context, '/sign-in');
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
