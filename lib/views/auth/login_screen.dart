import 'package:cliniq_core/views/auth/auth_controller.dart';
import 'package:cliniq_core/views/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:cliniq_core/views/auth/register_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController=Get.find<AuthController>();
  bool passwordVisible=true;
  bool loading=false;
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(

                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value){
                    authController.email.value=value;
                  },
                  decoration: InputDecoration(

                    hintText: 'Enter your email',
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF5F6FA),
                    prefixIcon: Icon(Icons.email)
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: passwordVisible,
                  onChanged: (value){
                    authController.password.value=value;
                  },
                  decoration: InputDecoration(

                      hintText: 'Enter your password',
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF5F6FA),
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          passwordVisible=!passwordVisible;
                        });
                      }, icon: Icon(!passwordVisible? Icons.visibility_off:Icons.visibility)),
                      prefixIcon: Icon(Icons.lock)
                  ),
                ),
                SizedBox(height: 20,),

              ],
            )
            ),
            Obx(()=>RoundedButton(text:authController.loading.value? 'Loading.....' :'Login', ontap:authController.login)),
            SizedBox(height: 20,),
            TextButton(onPressed: (){
              Get.to(RegisterScreen());
            }, child: Text('Create an account')),

          ],
        ),
      ),
    );
  }
}
