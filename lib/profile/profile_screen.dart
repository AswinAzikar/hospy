import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hospy/bottom_navigation/bottom_navbar.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/firebase/user_model.dart';
import 'package:hospy/gen/assets.gen.dart';
import 'package:hospy/landing_screen/landing_screen.dart';
import 'package:hospy/route_const/route_const.dart';
import 'package:hospy/widgets/buttons.dart';
import 'package:hospy/widgets/shim_wrapper.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/common_container.dart';
import 'widgets/profie_buttons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? _userModel;
  bool _isLoading = true;

  final bool _isMembersToggled = false;

  final List profileList = const ['User', 'Members'];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        logger.d("Fetching user data for UID: ${currentUser.uid}");
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          logger.w("user document found");
          setState(() {
            _userModel =
                UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
          });
        } else {
          logger.f("User document does not exist.");
        }
      } else {
        print("No user logged in.");
      }
    } catch (e) {
      logger.f('Error fetching user data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isUserLoaded = _userModel != null;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    TextTheme textStyleTheme = Theme.of(context).textTheme;

    Color pageColor = bgColor1;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
        leading: IconButton(
            onPressed: () {
              pushTo(
                context: context,
                toPage: const ProfileScreen(),
                style: PageTransitionType.rightToLeft,
              );
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: pageColor,
        ),
      ),
      backgroundColor: pageColor,
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonContainer(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: screenWidth * 0.1,
                        foregroundImage:
                            AssetImage(Assets.jpg.profilePhoto.path),
                      ),
                      gapLarge,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isUserLoaded
                              ? Column(
                                  children: [
                                    Text(
                                      _userModel!.name!,
                                      style: textStyleTheme.headlineSmall,
                                    ),
                                    gapLarge,
                                    Text(
                                      _userModel!.phoneNumber!,
                                      style: textStyleTheme.titleSmall,
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    ShimWrapper(
                                      child: Text(
                                        "USER NOT FOUND",
                                        style: textStyleTheme.headlineSmall,
                                      ),
                                    ),
                                    gapLarge,
                                    ShimWrapper(
                                      child: Text(
                                        "mobile number not found",
                                        style: textStyleTheme.titleSmall,
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ],
                  ),
                ),
                gapLarge,
                Container(
                  decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      ProfileButton(
                        onPressed: () {
                          logger.e("Memebers pressed");
                        },
                        label: "Members",
                        screenWidth: screenWidth,
                        textStyleTheme: textStyleTheme,
                        iconPath: Assets.svg.group,
                      ),
                      customDivider,
                      ProfileButton(
                        onPressed: () {},
                        label: "Account Settings",
                        screenWidth: screenWidth,
                        textStyleTheme: textStyleTheme,
                        iconPath: Assets.svg.accountSettings,
                      ),
                    ],
                  ),
                ),
                gapIV,
                LoadingButtonV1(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LandingScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  text: "Log out",
                  splashColor: Colors.transparent,
                  backgroundColor: const Color.fromARGB(255, 206, 28, 15),
                )
              ],
            ),
          )),
    );
  }
}
