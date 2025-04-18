import 'package:flutter/material.dart';

class EditNotes extends StatefulWidget {
  final Function(String, String) onSaveNote;

  const EditNotes({super.key, required this.onSaveNote});

  @override
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _saveNote() async {
    // Ensure widget is still mounted before making any UI changes
    if (!mounted) return;

    // Show a loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Perform your async save operation here. If it's fast, just wait for a short period.
      // Example: Simulating an async operation with Future.delayed:
      await Future.delayed(
        const Duration(milliseconds: 300),
      ); // Remove this if unnecessary

      // Call the onSaveNote callback after saving
      widget.onSaveNote(_titleController.text, _contentController.text);
    } catch (e) {
      // Handle any errors that may occur (optional)
      print("Error saving note: $e");
    } finally {
      // Close the loading dialog and navigate back
      if (mounted) {
        Navigator.pop(context); // Close the loading dialog
        Navigator.pop(context); // Go back to the previous screen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF14321D),
              Color(0xFF000000),
            ], // Dark green to black
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 10),
                // Fixed "HOMEWORK" title
                const Center(
                  child: Text(
                    "HOMEWORK",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Title Input
                TextField(
                  controller: _titleController,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Enter title (e.g., Activity 2: RLE)",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                ),
                const Divider(color: Colors.white38),
                // Content Input
                Expanded(
                  child: TextField(
                    controller: _contentController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                    decoration: const InputDecoration(
                      hintText: "Write your note here...",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Divider(color: Colors.white38),
                // Save Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _saveNote,
                    icon: const Icon(Icons.save, color: Colors.green),
                    label: const Text(
                      "Save",
                      style: TextStyle(color: Colors.green),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
