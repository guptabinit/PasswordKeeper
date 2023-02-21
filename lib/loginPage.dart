import 'package:flutter/material.dart';

import 'homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 11,),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 12,),
            TextField(
              controller: _passwordController,
              obscureText: true,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                hintText: 'Enter Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: (){
                  },
                ),
                prefixIcon: const Icon(Icons.password),
              ),
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
                onPressed: (){
                  if(_passwordController.text.isEmpty || _emailController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter all the details"))
                    );
                  } else {
                    if(_passwordController.text.toString() == "12345678" && _emailController.text.toString() == 'test@admin.com'){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Wrong email/password"))
                      );
                    }
                  }
                },
                child: const Text(
                    'Login'
                )),
          ],
        ),
      ),
    );
  }
}
