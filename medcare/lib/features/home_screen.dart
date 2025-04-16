import 'package:flutter/material.dart';
import 'bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> patients = [];
  final List<Map<String, dynamic>> schedule = [];

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
                  const Icon(Icons.settings, color: Colors.white),
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
                  // Sort By Dropdown
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
            Expanded(
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
                  const Icon(Icons.edit, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Schedule or "No schedule"
            Container(
              height: 150,
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
                            child: Text(
                              item['title'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new patient or schedule
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Color(0xFF0F2D1E)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
