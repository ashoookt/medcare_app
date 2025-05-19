import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Patient model class
class Patient {
  final String fullName;
  final String address;
  final String gender;
  final String age;
  final String doctor;
  final String room;

  Patient({
    required this.fullName,
    required this.address,
    required this.gender,
    required this.age,
    required this.doctor,
    required this.room,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const PatientRecordsScreen(),
    );
  }
}

// Screen where user inputs patient data
class PatientRecordsScreen extends StatefulWidget {
  const PatientRecordsScreen({super.key});

  @override
  State<PatientRecordsScreen> createState() => _PatientRecordsScreenState();
}

class _PatientRecordsScreenState extends State<PatientRecordsScreen> {
  // Controllers for input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();

  // Scheduled date string (optional)
  String scheduledDate = '';

  void _showDateInputDialog() {
    final monthController = TextEditingController();
    final dayController = TextEditingController();
    final yearController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2E4740),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Set Schedule',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _DateField(controller: monthController, hint: 'MM'),
              const SizedBox(height: 8),
              _DateField(controller: dayController, hint: 'DD'),
              const SizedBox(height: 8),
              _DateField(controller: yearController, hint: 'YYYY'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  scheduledDate =
                      '${monthController.text}/${dayController.text}/${yearController.text}';
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _saveAndShowInfo() {
    final patient = Patient(
      fullName: _nameController.text,
      address: _addressController.text,
      gender: _genderController.text,
      age: _ageController.text,
      doctor: _doctorController.text,
      room: _roomController.text,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => PatientInfoScreen(
              patient: patient,
              scheduledDate: scheduledDate,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF163C2C),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 240,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1E593C), Color(0xFF204C36)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(300, 100),
                    bottomRight: Radius.elliptical(300, 100),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Patient Records',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 24),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Avatar Row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Scheduled Button (aligned to right)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: _showDateInputDialog,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                scheduledDate.isEmpty
                                    ? "Scheduled"
                                    : scheduledDate,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  CustomTextField(
                    controller: _nameController,
                    hint: "Enter Name",
                  ),
                  CustomTextField(
                    controller: _addressController,
                    hint: "Enter Address",
                  ),
                  CustomTextField(
                    controller: _genderController,
                    hint: "Enter Gender",
                  ),
                  CustomTextField(
                    controller: _ageController,
                    hint: "Enter Age",
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextField(
                    controller: _doctorController,
                    hint: "Doctor Appointed",
                  ),
                  CustomTextField(
                    controller: _roomController,
                    hint: "Patient room/ward",
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundedButton(
                        text: "Edit",
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          // maybe add editing feature here
                        },
                      ),
                      RoundedButton(
                        text: "Delete",
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          // maybe add deleting feature here
                          _nameController.clear();
                          _addressController.clear();
                          _genderController.clear();
                          _ageController.clear();
                          _doctorController.clear();
                          _roomController.clear();
                          setState(() {
                            scheduledDate = '';
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  RoundedButton(
                    text: "Save",
                    color: Colors.black,
                    textColor: Colors.white,
                    fullWidth: true,
                    onPressed: _saveAndShowInfo,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom date field for the dialog
class _DateField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _DateField({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final bool fullWidth;
  final VoidCallback? onPressed;

  const RoundedButton({
    super.key,
    required this.text,
    required this.color,
    required this.textColor,
    this.fullWidth = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : 140,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 2,
        ),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// Screen to display patient info after saving
class PatientInfoScreen extends StatelessWidget {
  final Patient patient;
  final String scheduledDate;

  const PatientInfoScreen({
    super.key,
    required this.patient,
    required this.scheduledDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Patient Information"),
        backgroundColor: const Color(0xFF163C2C),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000000), Color(0xFF1C3F2F), Color(0xFF224932)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Row with profile picture and info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade900.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // RECTANGULAR PROFILE IMAGE
                      Container(
                        width: 90,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 16),

                      // INFO SECTION
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildInfoTile(
                              "Gender:",
                              patient.gender,
                              Icons.person,
                            ),
                            const SizedBox(height: 10),
                            buildInfoTile(
                              "Age:",
                              "${patient.age} years old",
                              Icons.calendar_today,
                            ),
                            const SizedBox(height: 10),
                            buildInfoTile(
                              "Address:",
                              patient.address,
                              Icons.location_on,
                            ),
                            const SizedBox(height: 10),
                            buildInfoTile(
                              "Doctor:",
                              patient.doctor,
                              Icons.medical_services,
                            ),
                            const SizedBox(height: 10),
                            buildInfoTile(
                              "Room/Ward:",
                              patient.room,
                              Icons.room,
                            ),
                            const SizedBox(height: 10),
                            buildInfoTile(
                              "Scheduled:",
                              scheduledDate.isEmpty ? "Not set" : scheduledDate,
                              Icons.schedule,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // NAME
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        patient.fullName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "PATIENT NAME",
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Styled info row
  Widget buildInfoTile(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(width: 8),
        Text(
          "$label ",
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(value, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
