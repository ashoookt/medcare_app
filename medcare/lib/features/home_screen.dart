import 'package:flutter/material.dart';
import 'bottom_navbar.dart';
import 'package:medcare/userProfile/settings_screen.dart';
import 'scheds_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> patients = [];
  List<Map<String, dynamic>> schedule =
      []; // Declare this as a field to persist across navigation

  String selectedSort = 'Sort By';
  String selectedGender = 'All';

  Widget genderIcon(String gender, IconData icon) {
    final isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.black,
          size: 24,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2D1E),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Text(
                    'PATIENT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),

                  // Settings Button
                  InkWell(
                    onTap: () {
                      // Pass the schedule to SettingsScreen to maintain data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  SettingsScreen(notifications: schedule),
                        ),
                      );
                    },
                    child: const Icon(Icons.settings, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Search
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Sort & Gender Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  PopupMenuButton<String>(
                    offset: const Offset(0, 40),
                    onSelected: (String value) {
                      setState(() {
                        selectedSort = value;
                      });
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    itemBuilder:
                        (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'Date',
                            child: Text('Date'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'A to Z',
                            child: Text('A to Z'),
                          ),
                        ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            selectedSort,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  genderIcon('Male', Icons.male),
                  genderIcon('Female', Icons.female),
                ],
              ),
            ),

            // Patient List or "No patient"
            Flexible(
              flex: 1,
              child:
                  patients.isEmpty
                      ? const Center(
                        child: Text(
                          'No patient listed.',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                      : ListView.builder(
                        itemCount: patients.length,
                        itemBuilder: (context, index) {
                          final patient = patients[index];
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.black54,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(
                              patient['name'],
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              patient['date'],
                              style: const TextStyle(color: Colors.white70),
                            ),
                          );
                        },
                      ),
            ),

            // Schedule Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Text(
                    'SCHEDULE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScheduleScreen(),
                        ),
                      );

                      if (result != null && result is Map<String, dynamic>) {
                        setState(() {
                          schedule.add(result); // Add new schedule to the list
                        });
                      }
                    },
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Schedule or "No schedule"
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child:
                    schedule.isEmpty
                        ? const Center(
                          child: Text(
                            'No schedule available.',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: schedule.length,
                          itemBuilder: (context, index) {
                            final item = schedule[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.teal[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${item['date']} | ${item['startTime']} - ${item['endTime']}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  if (item['notes'] != null &&
                                      item['notes'].trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        item['notes'],
                                        style: const TextStyle(
                                          color: Colors.white60,
                                          fontSize: 13,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
