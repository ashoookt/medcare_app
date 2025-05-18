import 'package:flutter/material.dart';

class PatientInfoScreen extends StatelessWidget {
  final TextEditingController doctorController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController complaintController = TextEditingController();
  final TextEditingController diagnosisController = TextEditingController();

  PatientInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1E25), // Dark background
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text("PATIENT INFORMATION"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Age / Sex',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Doctor Appointed
            buildInfoBox("Doctor Appointed", doctorController),

            // Patient Room/Ward
            buildInfoBox("Patient Room/Ward", roomController),

            // Chief Complaint
            buildInfoBox("Chief Complaint", complaintController, maxLines: 3),

            // Diagnosis & Procedures
            buildInfoBox(
              "Diagnosis & Procedures Performed",
              diagnosisController,
              maxLines: 3,
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle save logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoBox(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label, border: InputBorder.none),
      ),
    );
  }
}
