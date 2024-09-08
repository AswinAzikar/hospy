import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_toggle_button/flutter_toggle_button.dart';
import 'package:gap/gap.dart';
import 'package:hospy/bottom_navigation/bottom_navbar.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/custom_appbar/custom_appbar.dart';
import 'package:hospy/firebase/user_model.dart';
import 'package:hospy/gen/assets.gen.dart';
import 'package:hospy/widgets/shim_wrapper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

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

  bool _isMembersToggled = false;

  final List profileList = const ['User', 'Members'];

  void _toggleButtonPressed() {
    setState(() {
      _isMembersToggled = !_isMembersToggled;

      logger.w("you toggled members : $_isMembersToggled");
    });
    //  return _isMembersToggled;
  }

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
          print("User document does not exist.");
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
            onPressed: () => Navigator.push(
                  context,
                  PageTransition(
                    child: const CustomBottomNavigationBar(),
                    type: PageTransitionType.theme,
                  ),
                ),
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
                  //  backgroundColor: primaryColor3,
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
                              ? Text(
                                  _userModel!.name!,
                                  style: textStyleTheme.headlineSmall,
                                )
                              : ShimWrapper(
                                  child: Text(
                                    "USER NOT FOUND",
                                    style: textStyleTheme.headlineSmall,
                                  ),
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
                        onPressed: () {},
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
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
