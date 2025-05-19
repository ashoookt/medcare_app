import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientRecordsScreen extends StatefulWidget {
  const PatientRecordsScreen({super.key});

  @override
  State<PatientRecordsScreen> createState() => _PatientRecordsScreenState();
}

class _PatientRecordsScreenState extends State<PatientRecordsScreen> {
  // Controllers for the input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController doctorController = TextEditingController();
  final TextEditingController wardController = TextEditingController();

  bool isLoading = false;

  Future<void> savePatient() async {
    final String apiUrl = 'http://192.168.100.224:8000/patients';

    // Validate or parse inputs
    if (nameController.text.isEmpty ||
        addressController.text.isEmpty ||
        genderController.text.isEmpty ||
        ageController.text.isEmpty ||
        doctorController.text.isEmpty ||
        wardController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    final int? age = int.tryParse(ageController.text);
    if (age == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Age must be a number')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    final Map<String, dynamic> data = {
      "patient_name": nameController.text,
      "patient_address": addressController.text,
      "patient_gender": genderController.text,
      "patient_age": age,
      "patient_doctor": doctorController.text,
      "patient_ward": wardController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Patient saved successfully')),
        );
        // Optionally clear fields
        nameController.clear();
        addressController.clear();
        genderController.clear();
        ageController.clear();
        doctorController.clear();
        wardController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save patient: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    genderController.dispose();
    ageController.dispose();
    doctorController.dispose();
    wardController.dispose();
    super.dispose();
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
                crossAxisAlignment: CrossAxisAlignment.start,
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

                  // Avatar
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

                  // Scheduled button (keep your original _showDateInputDialog here)

                  // Your input fields with controllers:
                  CustomTextField(
                    controller: nameController,
                    hint: "Enter Name",
                  ),
                  CustomTextField(
                    controller: addressController,
                    hint: "Enter Address",
                  ),
                  CustomTextField(
                    controller: genderController,
                    hint: "Enter Gender",
                  ),
                  CustomTextField(
                    controller: ageController,
                    hint: "Enter Age",
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextField(
                    controller: doctorController,
                    hint: "Doctor Appointed",
                  ),
                  CustomTextField(
                    controller: wardController,
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
                          // Add Edit functionality here if needed
                        },
                      ),
                      RoundedButton(
                        text: "Delete",
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          // Add Delete functionality here if needed
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  RoundedButton(
                    text: isLoading ? "Saving..." : "Save",
                    color: Colors.black,
                    textColor: Colors.white,
                    fullWidth: true,
                    onPressed: isLoading ? null : savePatient,
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

// Modified CustomTextField to accept a controller and keyboardType
class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.keyboardType,
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
        controller: controller,
        keyboardType: keyboardType,
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
        onPressed: onPressed,
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
