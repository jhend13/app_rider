import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: NavigationBar(destinations: const [
        NavigationDestination(icon: Icon(Icons.abc_sharp), label: 'home'),
        NavigationDestination(icon: Icon(Icons.abc_sharp), label: 'yo'),
      ]),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back',
                style: Theme.of(context).textTheme.displaySmall),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
              child: Text('Sign in to start using AADD services.'),
            ),
            TextField(
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
              //style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            SizedBox(width: 0, height: 12),
            TextField(
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
            ),
            SizedBox(width: 0, height: 12),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Sign In'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
