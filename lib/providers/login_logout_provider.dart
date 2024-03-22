import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translation_app/providers/home_page_provider.dart';

// this provider will be for authontiction functions

class AuthMethodProvider extends ChangeNotifier {

  // text fields controler in sign in screen
  TextEditingController user_login_email = TextEditingController();
  TextEditingController user_login_password = TextEditingController();

  // text fildes coltroller in sing up screen
  TextEditingController user_signup_name = TextEditingController();
  TextEditingController user_signup_email = TextEditingController();
  TextEditingController user_signup_password = TextEditingController();

  // contrller for more detilse about user
  TextEditingController user_signup_addres = TextEditingController();
  TextEditingController user_signup_phone = TextEditingController();

  void cleanFields(){
    user_signup_name.clear();
    user_signup_email.clear();
    user_signup_password.clear();
    user_signup_phone.clear();
    user_signup_phone.clear();
    user_login_email.clear();
    user_login_password.clear();
    notifyListeners();
  }
  bool hidePassword = true;

  void hidePasswordMethod(){
    this.hidePassword = !this.hidePassword;
    notifyListeners();
  }

  String? addressValue;

  // waiting with circler progres part
  bool isCirceling = false;

  void startCirceler() {
     this.isCirceling = !this.isCirceling;
    notifyListeners();
  }

  // send the information to the firebas
  // deal with firebase

  regesterMethod() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: this.user_signup_email.text,
        password: this.user_signup_password.text
    );
  }

  loginMethod() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: this.user_login_email.text,
        password: this.user_login_password.text);
    notifyListeners();
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

// show message for exceptions
  exceptionFromRegisterMethod(val) {
    if (val == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (val == 'email-already-in-use') {
      return 'The account already exists for that email.';
    } else if (val == 'invalid-email') {
      return 'the email address is not valid.';
    }
  }

  exceptionFromLoginMethod(val) {
    if (val == 'invalid-credential') {
      return 'The password is wrong.';
    } else if (val == 'email-already-in-use') {
      return 'The account already exists for that email.';
    } else if (val == 'invalid-email') {
      return 'the email address is not valid.';
    }
  }

  // function to get current user id that will help us to store the data
  // in the collection on his id
  String? user_id;
  String? email;
  String? phoneNumber;
  Map<String, dynamic>? user_data;

  getCurrentUserIdAndEmail() async {
    this.user_id = await FirebaseAuth.instance.currentUser?.uid;
    this.email = await FirebaseAuth.instance.currentUser?.email;
    notifyListeners();
  }

  getCurrentUserData() async {
    this.isCirceling = true;
    var request = await FirebaseFirestore.instance
        .collection('users')
        .doc(this.user_id)
        .get();
    user_data = request.data();
    this.isCirceling = false;
    notifyListeners();
  }

  Map<String, dynamic>? user_map;

  setDataIntoMap() {
    user_map = {
      'UserName': user_signup_name.text,
      'PhoneNumber': user_signup_phone.text,
      'Address': user_signup_addres.text,
      'created_at': DateTime.now(),
    };
    notifyListeners();
  }

  // send the information like phone nuber and address to the
  // firebase and store it

  void storeUserState() async {
    await this.setDataIntoMap();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user_id)
        .set(user_map!);
    notifyListeners();
  }

// to update our data
  HomePageProvider home = HomePageProvider();
  TextEditingController updateval = TextEditingController();

  updateUserStates(String key, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user_id)
          .update({key: this.updateval.text});
      home.showMessagee(
          context, "operation accomplished successfully", Colors.green[400]);
    } catch (e) {
      home.showMessagee(context, "Error : The operation failed", Colors.red);
    }
    notifyListeners();
  }

  // function to open dilog to edit your data
  openDilog(dynamic cont, String filed, String val) {
    this.updateval.text = val;
    showDialog(
        context: cont,
        builder: (_) => AlertDialog(
              // contentPadding: EdgeInsets.only(bottom: 0),
              title: Text(filed),
              content: TextFormField(
                controller: this.updateval,
              ),
              actions: [
                TextButton(
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () async {
                    await this.updateUserStates(filed, cont);
                    await this.getCurrentUserData();
                    Navigator.of(cont).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.of(cont).pop();
                  },
                ),
              ],
            ));
  }

  // local storage: we will use it to check that if i login then
  // i will keep login if i close the app and open it agine
  bool? str;

  void inputLoginStorage(bool val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('login', val);
  }

  checkLoginStorage() async {
    bool? val;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool check = await prefs.getBool('login')!;
    // print('check is $check');
    if (check == true) {
      this.str = true;
    } else {
      this.str = false;
    }
    notifyListeners();
  }

  void inputLogoutStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('login');
  }
}
