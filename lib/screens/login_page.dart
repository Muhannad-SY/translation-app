import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:translation_app/base_things/my_colors.dart';
import 'package:translation_app/providers/home_page_provider.dart';
import 'package:translation_app/providers/login_logout_provider.dart';
import 'package:translation_app/screens/home_page.dart';
import 'package:translation_app/screens/registre_page.dart';

import '../widget/costum_text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final authMethoedProvider = Provider.of<AuthMethodProvider>(context);
    final myColor = MyColors();
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: myColor.myWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(85),
            Row(
              children: [
                Gap(30),
                Text('SIGN IN',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500))
              ],
            ),
            Gap(50),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 22, right: 20),
                width: double.infinity,
                // height: MediaQuery.of(context).size.height /1.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22))),

                // Gap(15),
                child: ListView(
                  children: [
                    Gap(20),
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                    Gap(5),
                    Text(
                      'Register a new Account and have this cool expirance',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    Gap(40),
                    Form(
                        key: _formKey,
                        child: Column(
                          // shrinkWrap: true,
                          // physics: ScrollPhysics(),
                          children: [
                            CostumNonTextFormFiled(
                              hide: false,
                              controller: authMethoedProvider.user_login_email ,
                              prefix: Icons.email,
                              valedateText:
                                  'please Dont leave this Filed Empty',
                              hintText: 'Email',
                            ),
                            Gap(5),
                            CostumNonTextFormFiled(
                              hideIcon: IconButton(onPressed: (){
                                Provider.of<AuthMethodProvider>(context , listen: false).hidePasswordMethod();
                              },
                                  icon: Icon(Icons.remove_red_eye)),
                              hide: authMethoedProvider.hidePassword,
                              controller: authMethoedProvider.user_login_password,
                              prefix: Icons.lock,
                              valedateText:
                                  'please Dont leave this Filed Empty',
                              hintText: 'password',
                            ),
                            Gap(5),
                            Container(
                              decoration: BoxDecoration(
                                  color: myColor.myWhite,
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.maxFinite,
                              child: TextButton(
                                onPressed: () async{
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      await Provider.of<AuthMethodProvider>(
                                          context,
                                          listen: false)
                                          .loginMethod();
                                      Provider.of<AuthMethodProvider>(context,
                                          listen: false)
                                          .inputLoginStorage(true);
                                      Navigator.pushAndRemoveUntil<void>(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomePage()),
                                        ModalRoute.withName('/'),);
                                      Provider.of<AuthMethodProvider>(context , listen: false).cleanFields();
                                    } on FirebaseAuthException catch (e) {
                                      print(e);
                                      var mess = Provider.of<
                                          AuthMethodProvider>(
                                          context, listen: false)
                                          .exceptionFromLoginMethod(e.code);
                                      Provider.of<HomePageProvider>(
                                          context, listen: false).showMessagee(context, mess, Colors.red);
                                    }
                                  }
                                },
                                child: const Text('SIGN IN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        )),
                    Gap(14),
                    Divider(
                      indent: 40,
                      endIndent: 40,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'I Don\'t Have Account',
                          style: TextStyle(fontSize: 12),
                        ),
                        TextButton(
                          child: Text('Sign up'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegistrePage()));
                          },
                        )
                      ],
                    )
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
