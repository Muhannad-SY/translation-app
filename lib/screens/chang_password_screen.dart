import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translation_app/base_things/my_colors.dart';
import 'package:translation_app/providers/change_password_provider.dart';
import 'package:translation_app/providers/home_page_provider.dart';
import 'package:translation_app/widget/costum_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final changePasswordProvider = Provider.of<ChangPasswordProvider>(context);
    final homePageprovider = Provider.of<HomePageProvider>(context);
    final mycolor = MyColors();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Enter Your Old Password'),
                CostumNonTextFormFiled(
                  hide: false,
                  controller: changePasswordProvider.oldPassword,
                ),
                Text('Enter Your newPassword Password'),
                CostumNonTextFormFiled(
                  hide: false,
                  controller: changePasswordProvider.newPassword,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: mycolor.myWhite,
                          borderRadius: BorderRadius.circular(15)),
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TextButton(
                        onPressed: () async {
                          Provider.of<ChangPasswordProvider>(context,
                                  listen: false)
                              .changeCircullerSatuation();
                          await Provider.of<ChangPasswordProvider>(context,
                                  listen: false)
                              .editYourPassword(context);

                          Provider.of<ChangPasswordProvider>(context,
                                  listen: false)
                              .changeCircullerSatuation();

                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Text(
                              "Change your Password",
                              style: TextStyle(color: Colors.white),
                            ),
                            (changePasswordProvider.circ == false)
                                ? SizedBox()
                                : CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: Colors.white,
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
