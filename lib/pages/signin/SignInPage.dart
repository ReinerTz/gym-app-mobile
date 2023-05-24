import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app_mobile/pages/signin/SignInController.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final controller = SignInController();
  String? _email;
  String? _password;

  Widget loginForm() {
    return Form(
      key: _formKey,
      child: Center(
        child: Card(
          
          child: Container(
            height: 600,
            width: 300,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 110,),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Por favor, digite o email';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Por favor, digite a senha';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 15.0,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == true) {
                        _formKey.currentState?.save();

                        await controller.signIn(_email!, _password!);
                      }
                    },
                    child: const Text('Entrar', style: TextStyle(color: Colors.white60),),
                  ),
                ),
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () {

                  },
                  child: const Text('Esqueci minha senha'),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    // Aqui você pode implementar a lógica para "Cadastre-se"
                  },
                  child: const Text('Cadastre-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 37, 37, 37)),
        width: double.maxFinite,
        height: double.maxFinite,
        child: Obx(() {
          if (controller.loading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return loginForm();
        }),
      ),
    );
  }
}
