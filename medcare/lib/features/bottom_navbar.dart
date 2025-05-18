import 'package:flutter/material.dart';
import 'package:medcare/features/home_screen.dart';
import 'package:medcare/features/notes_screen.dart';
import 'package:medcare/patientProfile/patientRecs_screen.dart';
import 'package:medcare/patientProfile/medhistory_screen.dart';
import 'package:medcare/patientProfile/vitals_screen.dart';
import 'package:medcare/patientProfile/medsTreats_screen.dart';
import 'package:medcare/patientProfile/fluids_screen.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'lib/images/navigation.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Home Button
          Positioned(
            left: 90,
            bottom: 22,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  // Navigate to the HomeScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Image.asset(
                  'lib/images/Home.png',
                  width: 36,
                  height: 36,
                ),
              ),
            ),
          ),

          // Notes Button
          Positioned(
            right: 90,
            bottom: 22,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  // Navigate to the NotesScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotesScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  'lib/images/Notes.png',
                  width: 36,
                  height: 36,
                ),
              ),
            ),
          ),

          // Center Add (+) Button
          Positioned(
            bottom: 20,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(52),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 16),
                          ListTile(
                            leading: const Icon(Icons.assignment),
                            title: const Text('Patient Medical Records'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const PatientRecordsScreen(),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.history),
                            title: const Text('Patient Medical History'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const MedicalHistoryScreen(),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.monitor_heart),
                            title: const Text(
                              'Patient Vital Signs & Monitoring',
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const VitalSigns(),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.medical_services),
                            title: const Text('Patient Medications'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const MedicationScreen(),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.water_drop),
                            title: const Text('Patient Intravenous Fluids'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const IVFluidScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  );
                },

                child: Image.asset(
                  'lib/images/ButtonPlus.png',
                  width: 105,
                  height: 105,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
