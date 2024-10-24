import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

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
        bottomNavigationBar: NavigationBar(destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'home'),
          NavigationDestination(icon: Icon(Icons.home), label: 'home'),
          NavigationDestination(icon: Icon(Icons.home), label: 'home'),
          NavigationDestination(icon: Icon(Icons.home), label: 'home'),
        ]),
        body: Padding(
            padding: EdgeInsets.all(32),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Create Account',
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
                      SizedBox(width: 0, height: 12),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        autofillHints: [AutofillHints.password],
                        decoration: InputDecoration(
                            filled: true,
                            label: Text('Confirm Password'),
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.surface,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            )),
                        //style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: Text('Create Account'),
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
                              TextSpan(text: 'Already have an account? '),
                              TextSpan(
                                text: 'Sign in',
                                recognizer: _tapRecognizer
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(
                                        context, '/sign-in');
                                    //Navigator.pushNamed(context, '/sign-in');
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
