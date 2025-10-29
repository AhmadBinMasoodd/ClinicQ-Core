
import 'package:get/get.dart';

class AuthController extends GetxController {
  var email=''.obs;
  var password=''.obs;
  var loading=false.obs;
  void login(){
    print(email.value);
    print((password.value));
  }
  void logout(){

  }
  void register(){

  }
}