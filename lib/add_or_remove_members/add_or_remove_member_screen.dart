import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospy/add_or_remove_members/service/members_service.dart';
import 'package:hospy/bottom_navigation/bottom_navbar.dart';
import 'package:hospy/constants/value_const.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/color_const.dart';
import '../route_const/route_const.dart';
import 'models/members_data_model.dart';

class AddOrRemoveMemberScreen extends StatefulWidget {
  const AddOrRemoveMemberScreen({super.key});

  @override
  State<AddOrRemoveMemberScreen> createState() =>
      _AddOrRemoveMemberScreenState();
}

class _AddOrRemoveMemberScreenState extends State<AddOrRemoveMemberScreen> {
  late Future<List<FamilyMember>> _familyMembersFuture;

  @override
  void initState() {
    super.initState();
    _familyMembersFuture = FamilyService.i.loadFamilyData();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textStyleTheme = Theme.of(context).textTheme;
    Color pageColor = bgColor1;
    TextStyle relationStyle = textStyleTheme.bodyLarge!
        .copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.w300);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Members"),
        leading: IconButton(
          onPressed: () {
            pushTo(
              context: context,
              toPage: const CustomBottomNavigationBar(),
              style: PageTransitionType.leftToRight,
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: pageColor,
        ),
      ),
      body: FutureBuilder<List<FamilyMember>>(
        future: _familyMembersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No family members found.'));
          } else {
            List<FamilyMember> familyMembers = snapshot.data!;

            return ListView.builder(
              itemCount: familyMembers.length,
              itemBuilder: (context, index) {
                FamilyMember member = familyMembers[index];
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member.name,
                            style: textStyleTheme.headlineSmall!
                                .copyWith(color: primaryColor2),
                          ),
                          Text(
                            member.relation,
                            style: relationStyle,
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Ionicons.trash_outline),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
