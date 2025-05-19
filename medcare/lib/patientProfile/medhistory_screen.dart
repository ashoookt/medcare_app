import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:medcare/features/home_screen.dart';

class MedicalHistoryScreen extends StatefulWidget {
  const MedicalHistoryScreen({super.key});

  @override
  State<MedicalHistoryScreen> createState() => _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  final _complaintController = TextEditingController();
  final _diagnosticsController = TextEditingController();
  final _dietController = TextEditingController();

  int patientId = 1; // Replace with actual patient ID
  int? medicalRecordId; // Store the ID for update/delete

  @override
  void dispose() {
    _complaintController.dispose();
    _diagnosticsController.dispose();
    _dietController.dispose();
    super.dispose();
  }

  Future<void> saveMedicalHistory() async {
    final response = await http.post(
      Uri.parse(
        'http://192.168.100.224:8000/medical-history/',
      ), // Replace with your backend IP
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "patient_complaint": _complaintController.text,
        "patient_diagnostics": _diagnosticsController.text,
        "patient_diet": _dietController.text,
        "patient_id": patientId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      setState(() {
        medicalRecordId = data["id"];
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Saved successfully")));
    } else {
      debugPrint("Save error: ${response.body}");
    }
  }

  Future<void> updateMedicalHistory() async {
    if (medicalRecordId == null) return;

    final response = await http.put(
      Uri.parse('http://<your-ip>:8000/medical_history/$medicalRecordId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "patient_complaint": _complaintController.text,
        "patient_diagnostics": _diagnosticsController.text,
        "patient_diet": _dietController.text,
        "patient_id": patientId,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Updated successfully")));
    } else {
      debugPrint("Update error: ${response.body}");
    }
  }

  Future<void> deleteMedicalHistory() async {
    if (medicalRecordId == null) return;

    final response = await http.delete(
      Uri.parse('http://<your-ip>:8000/medical_history/$medicalRecordId'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _complaintController.clear();
        _diagnosticsController.clear();
        _dietController.clear();
        medicalRecordId = null;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Deleted successfully")));
    } else {
      debugPrint("Delete error: ${response.body}");
    }
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
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Medical History &\nChief Complaint',
                        textAlign: TextAlign.center,
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
                  const SizedBox(height: 40),
                  CustomMultilineField(
                    hint: 'Chief Complaint',
                    controller: _complaintController,
                  ),
                  CustomMultilineField(
                    hint: 'Diagnosis & Procedures Performed',
                    controller: _diagnosticsController,
                  ),
                  CustomMultilineField(
                    hint: 'Diet Type',
                    controller: _dietController,
                    lines: 12,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundedButton(
                        text: "Edit",
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: updateMedicalHistory,
                      ),
                      RoundedButton(
                        text: "Delete",
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: deleteMedicalHistory,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  RoundedButton(
                    text: "Save",
                    color: Colors.black,
                    textColor: Colors.white,
                    fullWidth: true,
                    onPressed: saveMedicalHistory,
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

// Updated to support controller
class CustomMultilineField extends StatelessWidget {
  final String hint;
  final int lines;
  final TextEditingController controller;

  const CustomMultilineField({
    super.key,
    required this.hint,
    required this.controller,
    this.lines = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: lines,
        decoration: InputDecoration(
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
