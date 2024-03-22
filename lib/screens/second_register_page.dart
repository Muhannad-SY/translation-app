import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:translation_app/screens/home_page.dart';
import '../base_things/my_colors.dart';
import '../providers/login_logout_provider.dart';
import '../widget/costum_text_field.dart';

class SecoundRegisterPage extends StatefulWidget {
  @override
  State<SecoundRegisterPage> createState() => _SecoundRegisterPageState();
}

class _SecoundRegisterPageState extends State<SecoundRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthMethodProvider>(context, listen: false).getCurrentUserIdAndEmail();
  }

  @override
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
            Gap(80),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 22, right: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
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
                      'Enter Your Phone Number And Your City Where You Live',
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
                          children: [
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            CostumNonTextFormFiled(
                              hide: false,
                              controller: authProvider.user_signup_phone,
                              prefix: Icons.phone_android,
                              valedateText:
                                  'please Dont leave this Filed Empty',
                              hintText: 'Phone Number',
                            ),
                            Text(
                              'Address',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            CostumNonTextFormFiled(
                              hide: false,
                              controller: authProvider.user_signup_addres,
                              prefix: Icons.location_on,
                              valedateText:
                                  'please Dont leave this Filed Empty',
                              hintText: 'Input Your Address',
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: myColor.myWhite,
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<AuthMethodProvider>(context,
                                              listen: false)
                                          .startCirceler();
                                      try {
                                        Provider.of<AuthMethodProvider>(context,
                                                listen: false)
                                            .storeUserState();

                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()));
                                        Provider.of<AuthMethodProvider>(context , listen: false).inputLoginStorage(true);
                                        Provider.of<AuthMethodProvider>(context , listen: false).cleanFields();
                                      } catch (e) {
                                        print('an error${e}');
                                      }
                                    },
                                    child: const Text('REGISTER',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  (authProvider.isCirceling)
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 1,
                                          ),
                                        )
                                      : SizedBox(),
                                ],
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
                          onPressed: () {},
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
