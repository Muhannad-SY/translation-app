import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:translation_app/base_things/my_colors.dart';
import 'package:translation_app/providers/home_page_provider.dart';
import 'package:translation_app/providers/login_logout_provider.dart';
import 'package:translation_app/screens/login_page.dart';
import 'package:translation_app/screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomePageProvider>(context, listen: false).initalizeSpeaker();
  }

  @override
  Widget build(BuildContext context) {
    final homePageProvider = Provider.of<HomePageProvider>(context);
    final authMethoedProvider = Provider.of<AuthMethodProvider>(context);
    final myColors = MyColors();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            icon: Icon(Icons.person , color: Colors.white, size: 30,),
          ),
        ],
        backgroundColor: myColors.myWhite,
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(0))),
        title: Text(
          'T R A N S L A T O R',
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[300],
      body: ListView(
        children: [
          Gap(25),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
            child: Card(
              color: myColors.myWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(140)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //show sheet bottom will provide chose langugae
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                  color: Colors.white,
                                ),
                                height: 300,
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text('Chose Language',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        height: 260,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: homePageProvider
                                              .languages.keys.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(homePageProvider
                                                  .languages.keys
                                                  .elementAt(index)),
                                              onTap: () {
                                                Provider.of<HomePageProvider>(
                                                        context,
                                                        listen: false)
                                                    .changeInputLanguage(
                                                        homePageProvider
                                                            .languages.keys
                                                            .elementAt(index));
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            homePageProvider.inputLanguage,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          Icon(Icons.keyboard_arrow_down_sharp,
                              color: Colors.white)
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Provider.of<HomePageProvider>(context, listen: false)
                              .exchangeLanguages();
                        },
                        child: Icon(
                          Icons.compare_arrows,
                          color: Colors.white,
                          size: 27,
                        )),
                    // output language deportment
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                  color: Colors.white,
                                ),
                                height: 300,
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text('Chose Language',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        height: 260,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: homePageProvider
                                              .languages.keys.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(homePageProvider
                                                  .languages.keys
                                                  .elementAt(index)),
                                              onTap: () {
                                                print(index);
                                                Provider.of<HomePageProvider>(
                                                        context,
                                                        listen: false)
                                                    .changeOutputLanguage(
                                                        homePageProvider
                                                            .languages.keys
                                                            .elementAt(index) , homePageProvider
                                                    .languages.values
                                                    .elementAt(index) );
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Text(homePageProvider.outputLanguage,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.keyboard_arrow_down_sharp,
                              color: Colors.white)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 15, 13, 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 7),
              height: 200,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EditableText(
                    maxLines: 6,
                    scribbleEnabled: false,
                    controller: homePageProvider.inputText,
                    focusNode: homePageProvider.focusNode,
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    cursorColor: Colors.blue,
                    backgroundCursorColor: Colors.grey,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Provider.of<HomePageProvider>(context,
                                      listen: false)
                                  .clearInput();
                            },
                            child: Icon(
                              Icons.clear,
                              size: 30,
                            ),
                          ),
                          Gap(10),
                          GestureDetector(
                              onTap: () async {
                                Provider.of<HomePageProvider>(context,
                                        listen: false)
                                    .changeRecordState();

                                await Provider.of<HomePageProvider>(context,
                                        listen: false)
                                    .recordSpeechToText();
                              },
                              child: Icon(
                                Icons.mic,
                                size: 30,
                                color: homePageProvider.isRecord == false
                                    ? null
                                    : Colors.red,
                              )),
                        ],
                      ),
                      Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: myColors.myWhite),
                        child: TextButton(
                          child: Text(
                            'TRANSLATE',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (homePageProvider.inputText.text.length > 1) {
                              await Provider.of<HomePageProvider>(context,
                                      listen: false)
                                  .translationRequest();
                            } else if (homePageProvider.outputText.length < 1) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'please write anything to translate')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'please write anything to translate')));
                            }
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 1, 13, 1),
            child: Container(
              height: 270,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: SelectableText(
                homePageProvider.outputText,
                style: TextStyle(color: Colors.black, fontSize: 20),
                maxLines: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
