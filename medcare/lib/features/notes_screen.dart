import 'package:flutter/material.dart';
import 'editnotes_screen.dart';
import 'bottom_navbar.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Map<String, String>> _notes = [];

  void _addNote(String title, String content) {
    setState(() {
      _notes.add({'title': title, 'content': content});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A2A1D),
      body: HomeContent(notes: _notes, onNoteSaved: _addNote),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}

class HomeContent extends StatelessWidget {
  final List<Map<String, String>> notes;
  final Function(String, String) onNoteSaved;

  const HomeContent({
    super.key,
    required this.notes,
    required this.onNoteSaved,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF2E4B3B), Color(0xFF1A2A1D)],
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                    child: SizedBox(), // Icons removed as requested
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "EVERYDAY RULES",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    _buildCard(
                      "DO’s:\n"
                      "- Wear proper uniform and ID at all times.\n"
                      "- Practice proper hand hygiene.\n"
                      "- Be punctual and respectful to patients.\n"
                      "- Record accurate and honest documentation.\n"
                      "- Follow protocols and instructor guidance.",
                      Alignment.topLeft,
                      220,
                    ),
                    const SizedBox(height: 10),
                    _buildCard(
                      "DON’Ts:\n"
                      "- Do not use your phone during clinical duty.\n"
                      "- Never falsify records or vital signs.\n"
                      "- Avoid gossiping or loud talking in wards.\n"
                      "- Don’t ignore patient safety protocols.\n"
                      "- Do not leave duty without permission.",
                      Alignment.topLeft,
                      220,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Notes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Stack(
                      children: [
                        _buildNoteCard(notes),
                        Positioned(
                          bottom: 15,
                          right: 15,
                          child: FloatingActionButton(
                            backgroundColor: Colors.greenAccent,
                            mini: true,
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          EditNotes(onSaveNote: onNoteSaved),
                                ),
                              );

                              if (result != null) {
                                final newNote = result as Map<String, String>;
                                onNoteSaved(
                                  newNote['title']!,
                                  newNote['content']!,
                                );
                              }
                            },
                            child: const Icon(Icons.add, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String text, Alignment alignment, double height) {
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Align(
        alignment: alignment,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildNoteCard(List<Map<String, String>> notes) {
    return Container(
      width: double.infinity,
      height: 300,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF3E6B5B),
        borderRadius: BorderRadius.circular(10),
        border: const Border(
          left: BorderSide(color: Colors.greenAccent, width: 3),
        ),
        boxShadow: [
          const BoxShadow(
            color: Colors.white,
            spreadRadius: 3,
            blurRadius: 0,
            offset: Offset(-5, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "HOMEWORKS",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          notes.isEmpty
              ? const Center(
                child: Text(
                  "No notes yet. Add a note using the + button.",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              )
              : Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            note['content']!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          if (index < notes.length - 1)
                            const Divider(color: Colors.white54, thickness: 1),
                        ],
                      );
                    },
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.65,
      size.width * 0.5,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.85,
      size.width,
      size.height * 0.75,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
