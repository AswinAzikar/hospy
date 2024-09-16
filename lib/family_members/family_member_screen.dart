import 'package:flutter/material.dart';
import 'package:hospy/constants/color_const.dart';
import 'package:ionicons/ionicons.dart';

import 'service/family_service.dart'; // Update with your actual path

class FamilyMembersScreen extends StatefulWidget {
  const FamilyMembersScreen({super.key});

  @override
  _FamilyMembersScreenState createState() => _FamilyMembersScreenState();
}

class _FamilyMembersScreenState extends State<FamilyMembersScreen> {
  List<Map<String, dynamic>> _familyMembers = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadFamilyData();
  }

  Future<void> _loadFamilyData() async {
    try {
      final members = await FamilyService.i.loadFamilyData();
      setState(() {
        _familyMembers = members;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Failed to load family data.";
      });
      print("Error loading family data: $e");
    }
  }

  Future<void> _removeFamilyMember(int index) async {
    final member = _familyMembers[index];
    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Removal'),
        content: Text('Are you sure you want to remove ${member['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (shouldRemove ?? false) {
      setState(() {
        _familyMembers.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textStyleTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Members'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : ListView.builder(
                  itemCount: _familyMembers.length,
                  itemBuilder: (context, index) {
                    final member = _familyMembers[index];
                    return ListTile(
                      title: Text(member['name'],
                          style: textStyleTheme.titleLarge),
                      subtitle: Text(
                        member['relation'],
                        style: textStyleTheme.bodyMedium!.copyWith(
                            color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                      trailing: IconButton(
                        highlightColor: primaryColor2,
                        onPressed: () => _removeFamilyMember(index),
                        icon: const Icon(Ionicons.trash),
                      ),
                    );
                  },
                ),
    );
  }
}
