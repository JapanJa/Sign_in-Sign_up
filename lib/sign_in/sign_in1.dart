import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignIn(),
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Center(
          child: isSmallScreen
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    _Logo(),
                    _FormContent(),
                    _SignUpButton(),
                  ],
                )
              : Container(
                  padding: const EdgeInsets.all(32.0),
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Row(
                    children: const [
                      Expanded(child: _Logo()),
                      Expanded(
                        child: Center(
                          child: Column(
                            children: [
                              _FormContent(),
                              _SignUpButton(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}


class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'lib/assets/image/image7.jpg',
          width: isSmallScreen ? 200 : 600,
          height: isSmallScreen ? 200 : 600,
          fit: BoxFit.contain,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headline5
                : Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0.9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value);
                if (!emailValid) {
                  return 'Please enter a valid email';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            _gap(),
            CheckboxListTile(
              value: _rememberMe,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _rememberMe = value;
                });
              },
              title: const Text('Remember me'),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: const EdgeInsets.all(0),
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Handle sign-in logic here
                  }
                },
              ),
            ),
            _gap(),
            Text(
              "Or sign in with:",
              style: Theme.of(context).textTheme.caption,
            ),
            _gap(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Google sign-in here
                  },
                  icon: Image.asset('lib/assets/image/google.png',
                      width: 24, height: 24),
                  label: Text('Google'),
                ),
                SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Facebook sign-in here
                  },
                  icon: Image.asset('lib/assets/image/facebook.png',
                      width: 24, height: 24),
                  label: Text('Facebook'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navigate to the sign-up page when the button is clicked
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SignUpPage(), // Replace with your sign-up page widget
        ));
      },
      child: Text(
        'Sign Up',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}



class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      TextField(
        controller: _usernameController,
        decoration: InputDecoration(labelText: 'Username'),
      ),
      SizedBox(height: 16.0),
      TextField(
        controller: _emailController,
        decoration: InputDecoration(labelText: 'Email Address'),
      ),
      SizedBox(height: 16.0),
      TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(labelText: 'Password'),
      ),
      SizedBox(height: 16.0),
      TextField(
        controller: _confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(labelText: 'Confirm Password'),
      ),
      SizedBox(height: 32.0),
      ElevatedButton(
        onPressed: () {
          // Implement your sign-up logic here

          final username = _usernameController.text;
          final email = _emailController.text;
          final password = _passwordController.text;
          final confirmPassword = _confirmPasswordController.text;

          // Perform validation and sign-up process
        },
        child: Text('Sign Up'),
      ),
      SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: () {
          // Implement Google sign-up logic here
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white, // Change the color to match Google's branding
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'lib/assets/image/google.png',
              width: 24,
              height: 24,
            ),
            SizedBox(width: 8.0), // Add spacing between icon and text
            Text('Google'),
          ],
        ),
      ),
      SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: () {
          // Implement Facebook sign-up logic here
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white, // Change the color to match Facebook's branding
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'lib/assets/image/facebook.png',
              width: 24,
              height: 24,
            ),
            SizedBox(width: 8.0), // Add spacing between icon and text
            Text('Facebook'),
          ],
        ),
      ),
    ],
  );
}
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}


