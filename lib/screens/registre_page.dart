import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:translation_app/base_things/my_colors.dart';
import 'package:translation_app/providers/home_page_provider.dart';
import 'package:translation_app/screens/login_page.dart';
import 'package:translation_app/screens/second_register_page.dart';
import '../providers/login_logout_provider.dart';

import '../widget/costum_text_field.dart';

class RegistrePage extends StatefulWidget {
  @override
  State<RegistrePage> createState() => _RegistrePageState();
}

class _RegistrePageState extends State<RegistrePage> {
  @override
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthMethodProvider>(context);
    final myColor = MyColors();
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: myColor.myWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(65),
            Row(
              children: [
                Gap(20),
                Text('SIGN UP',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500))
              ],
            ),
            Gap(35),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 22, right: 20),
                width: double.infinity,
                // height: MediaQuery.of(context).size.height /1.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),

                // Gap(15),
                child: ListView(
                  children: [
                    Gap(11),
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      'Register a new Account and have this cool expirance',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    Gap(25),
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // shrinkWrap: true,
                          // physics: ScrollPhysics(),
                          children: [
                            Text('Full Name',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            CostumNonTextFormFiled(
                              hide: false,
                              controller: authProvider.user_signup_name,
                              prefix: Icons.person,
                              valedateText:
                                  'please Dont leave this Filed Empty',
                              hintText: 'Muhammad Ali...',
                            ),
                            Text('Email',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            CostumNonTextFormFiled(
                              hide: false,
                              controller: authProvider.user_signup_email,
                              prefix: Icons.email,
                              valedateText:
                                  'please Dont leave this Filed Empty',
                              hintText: '...@example.com',
                            ),
                            Text('Password',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            CostumNonTextFormFiled(
                              hideIcon: IconButton(onPressed: (){
                                Provider.of<AuthMethodProvider>(context , listen: false).hidePasswordMethod();
                              },
                              icon: Icon(Icons.remove_red_eye)),
                              hide: authProvider.hidePassword,
                              controller: authProvider.user_signup_password,
                              prefix: Icons.lock,
                              valedateText:
                                  'please Dont leave this Filed Empty',
                              hintText: '7&#93%8@',
                            ),
                            Gap(5),
                            Container(
                              decoration: BoxDecoration(
                                  color: myColor.myWhite,
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.maxFinite,
                              child: TextButton(
                                onPressed: () async {
                                  setState(() {

                                  });
                                  if (_formKey.currentState!.validate()) {

                                  Provider.of<AuthMethodProvider>(context,
                                          listen: false)
                                      .startCirceler();

                                  try {
                                    await Provider.of<AuthMethodProvider>(
                                            context,
                                            listen: false)
                                        .regesterMethod();

                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SecoundRegisterPage()));
                                  } on FirebaseAuthException catch (e) {
                                  var mess =   Provider.of<AuthMethodProvider>(context,
                                            listen: false)
                                        .exceptionFromRegisterMethod(e.code);
                                  Provider.of<HomePageProvider>(context,
                                            listen: false)
                                        .showMessagee(context , mess , Colors.red);
                                  }
                                  Provider.of<AuthMethodProvider>(context,
                                          listen: false)
                                      .startCirceler();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Text('NEXT',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    (authProvider.isCirceling)
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 1,
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                    Gap(10),
                    Divider(
                      indent: 40,
                      endIndent: 40,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already Have an Account',
                          style: TextStyle(fontSize: 12),
                        ),
                        TextButton(
                          child: Text('Login'),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                        )
                      ],
                    ),
                   const Text('@This App Developed By Muhannad-SY',textAlign: TextAlign.center  , style: TextStyle(color: Colors.black , fontSize: 13),),
                   const Text('email: muhannad55sy@gmail.com',textAlign: TextAlign.center  , style: TextStyle(color: Colors.black , fontSize: 13),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
