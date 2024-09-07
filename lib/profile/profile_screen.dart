import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:hospy/firebase/user_model.dart';
import 'package:hospy/gen/assets.gen.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? _userModel;
  bool _isLoading = true;

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
    double screenHeight = MediaQuery.of(context).size.height;
    TextTheme textStyleTheme = Theme.of(context).textTheme;

    return ColorfulSafeArea(
      topColor: buttonColor,
      child: Scaffold(
        backgroundColor: bgColor1,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Profile",
                      style: textStyleTheme.headlineLarge!.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Gap(screenHeight * 0.07),
                Container(
                  decoration: BoxDecoration(
                    gradient: primaryGradience,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              foregroundImage:
                                  AssetImage(Assets.jpg.profilePhoto.path),
                            ),
                            const SizedBox(width: 16),
                            _isLoading
                                ? Shimmer.fromColors(
                                    baseColor: Colors.black45,
                                    highlightColor: Colors.white24,
                                    child: Container(
                                      width: 150,
                                      height: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                : _userModel != null
                                    ? Text(
                                        _userModel?.name ?? "Aswin Manmathan S",
                                        style: textStyleTheme.headlineSmall!
                                            .copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        'User not found',
                                        style: textStyleTheme.headlineSmall!
                                            .copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            _isLoading
                                ? Shimmer.fromColors(
                                    baseColor: Colors.black45,
                                    highlightColor: Colors.white24,
                                    child: Container(
                                      width: 150,
                                      height: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                : _userModel != null
                                    ? Text(
                                        _userModel?.email ??
                                            "Aswin Manmathan S",
                                        style: textStyleTheme.headlineSmall!
                                            .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        'User not found',
                                        style: textStyleTheme.headlineSmall!
                                            .copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
