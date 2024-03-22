import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:translation_app/screens/chang_password_screen.dart';

import '../base_things/my_colors.dart';
import '../providers/login_logout_provider.dart';
import 'login_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthMethodProvider>(context, listen: false)
        .getCurrentUserIdAndEmail()
        .then((_) async {
      await Provider.of<AuthMethodProvider>(context, listen: false)
          .getCurrentUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authMethoedProvider = Provider.of<AuthMethodProvider>(context);
    final myColors = MyColors();
    final widthSizeOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back, color: Colors.white)),
          backgroundColor: myColors.myWhite,
          title: Text(
            'Your Profile',
            style: TextStyle(
                fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.grey[300],
        body: ListView(children: [
          Container(
            color: Colors.grey[300],
            height: 160,
            child: Stack(children: [
              Positioned(
                child: Container(
                    height: 105,
                    // width: double.infinity,
                    color: myColors.myWhite),
              ),
              Positioned(
                  bottom: 0,
                  left: 70,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/my_user.jpeg'),
                  )),
            ]),
          ),
          (authMethoedProvider.user_data == null)
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : (authMethoedProvider.user_data == null &&
                      authMethoedProvider.isCirceling == false)
                  ? Flexible(
                      child: Center(
                        child: Text('You can not connect with the server'),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.person, size: 30),
                            title: Text(
                                '${authMethoedProvider.user_data!['UserName']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            trailing: IconButton(
                                onPressed: () {
                                  Provider.of<AuthMethodProvider>(context,
                                          listen: false)
                                      .openDilog(
                                          context,
                                          'UserName',
                                          authMethoedProvider
                                              .user_data!['UserName']);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 25,
                                )),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.email, size: 30),
                            title: Text('${authMethoedProvider.email}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.phone, size: 30),
                            title: Text(
                                '${authMethoedProvider.user_data!['PhoneNumber']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            trailing: IconButton(
                                onPressed: () {
                                  Provider.of<AuthMethodProvider>(context,
                                          listen: false)
                                      .openDilog(
                                          context,
                                          'PhoneNumber',
                                          authMethoedProvider
                                              .user_data!['PhoneNumber']);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 25,
                                )),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.location_on, size: 30),
                            title: Text(
                                '${authMethoedProvider.user_data!['Address']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            trailing: IconButton(
                                onPressed: () {
                                  Provider.of<AuthMethodProvider>(context,
                                          listen: false)
                                      .openDilog(
                                          context,
                                          'Address',
                                          authMethoedProvider
                                              .user_data!['Address']);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 25,
                                )),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.lock, size: 30),
                            title: Text('Password',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ChangePasswordScreen()));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 25,
                                )),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading:
                                Icon(Icons.logout, size: 30, color: Colors.red),
                            title: Text('Logout',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                            onTap: () async{
                              try {
                              await  Provider.of<AuthMethodProvider>(context,
                                        listen: false)
                                    .logout();
                                Navigator.pushAndRemoveUntil<void>(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginPage()),
                                  ModalRoute.withName('/'),);
                                Provider.of<AuthMethodProvider>(context,
                                        listen: false)
                                    .inputLogoutStorage();
                              } on FirebaseAuthException catch (e) {
                                print(e.code);
                              }
                            },
                          ),
                        ],
                      ),
                    )
        ]));
  }
}
