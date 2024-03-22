import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:translation_app/providers/home_page_provider.dart';
import 'package:translation_app/providers/login_logout_provider.dart';

class ChangPasswordProvider extends ChangeNotifier {

  HomePageProvider home = HomePageProvider();

  // changing button circuller
  bool circ = false;

  void changeCircullerSatuation() {
    this.circ = !this.circ;
    notifyListeners();
  }

  //ecidt your email and password
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();

  editYourPassword(BuildContext context) async {
    try {
      var cur_user = await FirebaseAuth.instance.currentUser;
      var email = await FirebaseAuth.instance.currentUser!.email;
      var cred = await EmailAuthProvider.credential(
          email: email!, password: this.oldPassword.text);

      await cur_user!
          .reauthenticateWithCredential(cred)
          .then((value) => {cur_user!.updatePassword(this.newPassword.text)})
          .catchError((onError) {
        print(onError.toString());
      });
      home.showMessagee(
          context, 'password get reset successfully.', Colors.green[400]);
    } catch (e) {
      home.showMessagee(context, 'New password doesn\'t exist.', Colors.red);
      print('you have error: $e');
    }
    notifyListeners();
  }
}
