import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/gen/assets.gen.dart';
import 'package:hospy/profile/profile_screen.dart';
import 'package:hospy/route_const/route_const.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:page_transition/page_transition.dart';

import '../firebase/user_model.dart';
import '../widgets/shim_wrapper.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  UserModel? _userModel;
  bool _isLoading = true;

  bool _isMembersToggled = false;

  final List profileList = const ['User', 'Members'];

  void _toggleButtonPressed() {
    setState(() {
      _isMembersToggled = !_isMembersToggled;

      logger.w("you toggled members : $_isMembersToggled");
    });
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
    TextTheme textStyleTheme = Theme.of(context).textTheme;
    bool isUserLoaded = _userModel != null;
    double screenWidth = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Stack(
          children: [
            Container(
              // width: screenWidth * 2.5 / 4,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Column(
                children: [],
              ),
            ),
            Positioned.fill(
              child: AnimatedMeshGradient(
                colors: multiGradientColorList,
                options: AnimatedMeshGradientOptions(frequency: 3),
              ),
            ),
            Column(
              children: [
                gapV,
                SizedBox(
                  width: screenWidth * 2.5 / 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: screenWidth * .13,
                              foregroundImage:
                                  AssetImage(Assets.jpg.profilePhoto.path),
                            ),
                          ],
                        ),
                        gapLarge,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isUserLoaded
                                ? Text(
                                    _userModel!.name!,
                                    style: textStyleTheme.titleLarge,
                                  )
                                : ShimWrapper(
                                    child: Text(
                                      "USER NOT FOUND",
                                      style: textStyleTheme.headlineSmall,
                                    ),
                                  ),
                          ],
                        ),
                        gapIV,
                        InkWell(
                          onTap: () {
                            pushTo(
                                context: context,
                                toPage: const ProfileScreen(),
                                style: PageTransitionType.rightToLeft);
                          },
                          enableFeedback: true,
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Ionicons.person),
                                Text("Account Settings",
                                    style: textStyleTheme.bodyLarge),
                                const Icon(Ionicons.arrow_forward_outline)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
