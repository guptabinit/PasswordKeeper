import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPasswordScreen extends StatefulWidget {
  const AddPasswordScreen({Key? key}) : super(key: key);

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {

  bool loading = false;

  final firestore = FirebaseFirestore.instance.collection('password');

  final _websiteController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _websiteController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _websiteController,
              decoration: InputDecoration(
                hintText: 'Enter website name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                prefixIcon: const Icon(Icons.link),
              ),
            ),
            const SizedBox(height: 12,),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email/username',
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
              decoration: InputDecoration(
                hintText: 'Enter Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                prefixIcon: const Icon(Icons.password),
              ),
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: (){
                if(_passwordController.text.isEmpty || _emailController.text.isEmpty || _websiteController.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Enter all the details"))
                  );
                } else {
                  setState(() {
                    loading = true;
                  });

                  String id = DateTime.now().millisecondsSinceEpoch.toString();

                  firestore.doc(id).set({
                    'id': id.toString(),
                    'website': _websiteController.text.toString(),
                    'username': _emailController.text.toString(),
                    'password': _passwordController.text.toString()
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Added Successfully"))
                    );
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error.toString()))
                    );
                  });
                }
              },
              child: loading? const Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator(color: Colors.white,) ,): const Text(
                  'Add Password'
              )),
          ],
        ),
      ),
    );
  }
}
